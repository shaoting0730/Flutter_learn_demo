import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter_blue/flutter_blue.dart';
import '../service/baseapi.dart';
import 'encode.dart';
import '../service/serviceapi.dart';
import '../models/iotdevice.dart';


Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'found_device':'Found Device',
      'cancel': 'CANCEL',
      'ok': "OK"
    },
    'zh': {
      'found_device':'发现设备',
      'cancel': '取消',
      'ok': "确定"
    },
  };

class LockerResponse
{
  int Command;
  String Value;
}
class BluetoothDeviceInfo
{
  int DoorStatus;
  double PowerPercentage;
  BluetoothDevice device;
  String Key;
  bool isConnected = false;
  BluetoothCharacteristic characteristic;
  StreamSubscription deviceStateSubscription;
  StreamSubscription deviceConnect;
  String Status = _localizedValues[getLocaleCode()]["found_device"];
  String DeviceUniqueID = '';
  String DeviceMACAddress = '';
  int StatusId = 0;
  String Password = '';
  List<int> arResponse = List<int>();
  void ClearSubscription(){
    Password = '';
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnect?.cancel();
    deviceConnect = null;
    device = null;
  }
}
class BluetoothUtility
{
  int getTimeZoneMinutes()
  {
    return DateTime.now().timeZoneOffset.inMinutes;
  }
  void showAlertDialog(BuildContext context, String title, String Message) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text(title),
            content: new Text(Message),
            actions:<Widget>[
              new FlatButton(child:new Text(_localizedValues[getLocaleCode()]["cancel"]), onPressed: (){
                Navigator.of(context).pop();

              },),
              new FlatButton(child:new Text(_localizedValues[getLocaleCode()]["ok"]), onPressed: (){
                Navigator.of(context).pop();

              },)
            ]
        ));
  }
  String getNextHexValue(arResponse, pos){
    if (arResponse[pos - 1] == 0x02) {
      var value = (arResponse[pos] & 0x0f).toRadixString(16);
      if(value.length<2)
        value = '0'+value;
      return value;
    }
    else {
      return arResponse[pos].toRadixString(16);
    }
  }
  LockerResponse parseSmartLockerResponse(BluetoothDeviceInfo foundDevice, List<int> arResponse) {
    LockerResponse response = new LockerResponse();
    response.Command = 0xff;
    response.Value = '';
    if(foundDevice==null)
      return response;
    print(arResponse.toString());
    print(foundDevice.arResponse.toString());
    List<int> arValidResponse = List<int>();
    List<int> arSecondResponse = List<int>();
    var i=0;
    bool bNeedFistPack = foundDevice.arResponse.length<1;
    bool bStartCopy = false;
    bool bUseSecondResponse = false;
    for(;i<arResponse.length;i++)
    {
      if(arResponse[i]!=0x00)
      {
        if(bNeedFistPack)
        {
          if(arResponse[i]==0x01)
            bStartCopy = true;
        }
        else
          bStartCopy = true;
      }
      if(bStartCopy)
      {
        if((arResponse[i]==0x01) || (arResponse[i]==0x03))
        {
          if(bUseSecondResponse)
          {
            if(!arSecondResponse.contains(arResponse[i]))
              arSecondResponse.add(arResponse[i]);
          }
          else
          {
            if(!arValidResponse.contains(arResponse[i]))
              arValidResponse.add(arResponse[i]);
          }
        }
        else
        {
          if(bUseSecondResponse)
            arSecondResponse.add(arResponse[i]);
          else
            arValidResponse.add(arResponse[i]);
        }
      }
      if(!bNeedFistPack)
      {
        if(arResponse[i]==0x03)
        {
          bUseSecondResponse = true;
          bNeedFistPack = true;
          bStartCopy = false;
        }
      }
    }
    if(arValidResponse.length<=0)
      return response;
    print(arValidResponse);
    if(arValidResponse[0]==0x01)
      foundDevice.arResponse.clear();
    else if(arValidResponse[arValidResponse.length-1]==0x03)
    {
      if(foundDevice.arResponse.length<=1 || foundDevice.arResponse[foundDevice.arResponse.length-1]==0x03)
        arValidResponse.clear();
    }
    foundDevice.arResponse.addAll(arValidResponse);
    if(foundDevice.arResponse[foundDevice.arResponse.length-1]!=0x03 || foundDevice.arResponse[0]!=0x01)
    {
      if(foundDevice.arResponse[foundDevice.arResponse.length-1]==0x03)
        foundDevice.arResponse.clear();
      return response;
    }

    var command = foundDevice.arResponse[8]==0x02?foundDevice.arResponse[9] & 0x0F : foundDevice.arResponse[8] & 0x0F;

    var value = '';
    switch (command) {
      case 0x04:
        {
          var nPos = foundDevice.arResponse[8]==0x02?14:13;
          while(foundDevice.arResponse[nPos]!=0x03)
          {
            if (foundDevice.arResponse[nPos] == 0x02)
              nPos += 1;
            if(value=='')
              value += getNextHexValue(foundDevice.arResponse, nPos);
            else
              value += ':' +getNextHexValue(foundDevice.arResponse, nPos);
            nPos += 1;
          }
        }
        break;
      case 0x05: ///get seq id
        {
          var nPos = foundDevice.arResponse[8]==0x02?14:13;
          if (foundDevice.arResponse[nPos] == 0x02)
            nPos += 1;
          value += getNextHexValue(foundDevice.arResponse, nPos);
          nPos += 1;
          if (foundDevice.arResponse[nPos] == 0x02)
            nPos += 1;
          value += getNextHexValue(foundDevice.arResponse, nPos);
          nPos += 1;
          if (foundDevice.arResponse[nPos] == 0x02)
            nPos += 1;
          value += getNextHexValue(foundDevice.arResponse, nPos);
          nPos += 1;
          if (foundDevice.arResponse[nPos] == 0x02)
            nPos += 1;
          value += getNextHexValue(foundDevice.arResponse, nPos);
        }
        break;
      case 0x03: ///Open door
      case 0x00: ///set time
      case 0x07:///battery
      case 0x06:///door status
      default:
        {
          var nPos = foundDevice.arResponse.length - 2;
          value = getNextHexValue(foundDevice.arResponse, nPos);
        }
        break;
    }
    response.Command = command;
    response.Value = value;
    foundDevice.arResponse.clear();
    if(arSecondResponse.length>0)
    {
      print(arSecondResponse);
      if(arSecondResponse[0]==0x01)
      {
        foundDevice.arResponse.addAll(arSecondResponse);
      }
    }
    return response;
  }

  Future<bool> RegisterDevice(BuildContext context, String UUID, String MACAddress, String QRCode, String DeviceName, String Description) async {
    IOTDeviceInfoModel register = new IOTDeviceInfoModel();
    register.DeviceUniqueId = UUID;
    register.DeviceMACAddress = MACAddress;
    register.DeviceTypeId = 0;
    register.Barcode = '';
    register.LinkProductGuid = '';
    register.Guid = '';
    register.MasterUserGuid = UserServerApi().getStoreCustomerGuid();
    register.DeviceQRCode = QRCode;
    register.DeviceName = DeviceName;
    register.DeviceType = '';
    register.Description = Description;
    register.CreatedOn = 0;
    register.UpdatedOn = 0;
    register.TimeZoneMinutes = getTimeZoneMinutes();
    return await UserServerApi().CreateNewIoTDevice(context, register);
  }
  void OpenLockerDoor(BluetoothDevice device, BluetoothCharacteristic characteristic, String Password) async{
    if(device == null) {
      return;
    }

    List<int> request = [0xa5,0x5a,0x03,0x00,0x04,0x00];
    String strPassword = int.parse(Password).toRadixString(16);
    if(strPassword.length < 6)
    {
      int nDif = 6-strPassword.length;
      for(int i=0;i<nDif;i++)
        strPassword = '0'+strPassword;
    }
    request.add(int.parse('0x'+strPassword.substring(0,2)));
    request.add(int.parse('0x'+strPassword.substring(2,4)));
    request.add(int.parse('0x'+strPassword.substring(4,6)));
    Uint8List sendmsg = Uint8List.fromList(request);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    var packLimit = 20;
    if (output.length > packLimit)
    {
      var pagNum = output.length / packLimit +1;
      for(var i=0;i<pagNum;i++)
      {
        var nLen = packLimit;
        if (output.length - i * packLimit < packLimit)
          nLen = output.length - i * packLimit;
        var dataList = output.sublist(i * packLimit, i * packLimit + nLen);
        await device.writeCharacteristic(characteristic, Uint8List.fromList(dataList));
        if (output.length - i * packLimit < packLimit)
          break;
      }
    }
    else
      device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  void SetDeviceTime(BluetoothDevice device, BluetoothCharacteristic characteristic) async{
    List<int> request = [0xa5,0x5a,0x00,0x00,0x04];
    var duration = new Duration(minutes: 480 - getTimeZoneMinutes());
    DateTime dtNow = DateTime.now().subtract(duration);
    int time = int.parse(dtNow.microsecondsSinceEpoch.toString().substring(0,10));
    String curTime = time.toRadixString(16);
    if(curTime.length % 2 >0)
    {
      curTime = '0'+curTime;
    }
    request.add(int.parse('0x'+curTime.substring(0,2)));
    request.add(int.parse('0x'+curTime.substring(2,4)));
    request.add(int.parse('0x'+curTime.substring(4,6)));
    request.add(int.parse('0x'+curTime.substring(6,8)));
    Uint8List sendmsg = Uint8List.fromList(request);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  void RequestMACAddress(BluetoothDevice device, BluetoothCharacteristic characteristic) async{
    List<int> request = [0xa5,0x5a,0x04,0x00,0x00];
    Uint8List sendmsg = Uint8List.fromList(request);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  void RequestBattery(BluetoothDevice device, BluetoothCharacteristic characteristic) async{
    List<int> request = [0xa5,0x5a,0x07,0x00,0x00];
    Uint8List sendmsg = Uint8List.fromList(request);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  void RequestDoorStatus(BluetoothDevice device, BluetoothCharacteristic characteristic) async{
    List<int> request = [0xa5,0x5a,0x06,0x00,0x00];
    Uint8List sendmsg = Uint8List.fromList(request);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  void RequestDeviceUUID(BluetoothDevice device, BluetoothCharacteristic characteristic) async{
    Uint8List sendmsg = Uint8List.fromList([0xa5,0x5a,0x05,0,0]);
    List<int> output = new List<int>();
    sendMessage(6,sendmsg,output);
    device.writeCharacteristic(characteristic, Uint8List.fromList(output));
  }
  BluetoothCharacteristic FindValidBluetoothCharacteristic(List<BluetoothService> services)
  {
    for(BluetoothService service in services)
    {
      for(BluetoothCharacteristic characteristic in service.characteristics)
      {
        if(characteristic.properties.writeWithoutResponse)
        {
          return  characteristic;
        }
      }
    }
  }
}