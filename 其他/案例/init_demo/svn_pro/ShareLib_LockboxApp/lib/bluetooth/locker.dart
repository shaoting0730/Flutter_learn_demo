import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'bluetoothUtility.dart';
import '../service/serviceapi.dart';
import '../service/baseapi.dart';
import '../models/iotdevice.dart';
import '../pages/base_page.dart';


Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'bluetooth_is_off':'Bluetooth is off',
      'open_bluetooth':'Please Turn on your bluetooth',
      'message':'Message',
      'not_on_time': "Not on time yet",
      'warning_device_disconnected':"The device is disconnected, please make sure the device is waked up.",
      'sync_time_success':'Sync time success',
      'sync_time_failed':'Sync time failed',
      'unlocking_failed':"Unlocking failed",
      'unlocking_success':"Unlocking success",
      'device_regisgtered':'Device Registered!',
      'device_regisgteredbefore':'Device Registered by another user!',
      'device_found': 'Device Found',
    },
    'zh': {
      'bluetooth_is_off':'蓝牙关闭了',
      'open_bluetooth':'请打开你的蓝牙',
      'message':'消息',
      'not_on_time': "还没有到指定时间",
      'warning_device_disconnected':"设备断开了连接，请确保设备是唤醒状态",
      'sync_time_success':'同步时间成功',
      'sync_time_failed':'同步时间失败',
      'unlocking_failed':"开锁失败",
      'unlocking_success':"开锁成功",
      'device_regisgtered':'设备注册成功！',
      'device_regisgteredbefore':'此设备已被其他用户注册!',
      'device_found': '发现设备',
    },
  };

class BluetoothLocker
{
  String _searchMACAddress = "";
  List<String> invalidDeviceIdList = List<String>();
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription _stateSubscription;
  StreamSubscription scanSubscription;
  BluetoothUtility utility = new BluetoothUtility();
  Function OnOpenDoorSuccess, OnOpenDoorFailed, OnCallback;
  bool bOpenedAlertDlg = false;
  BuildContext _context;
  BasePageState _callerPage;
  bool _isOpenDoor = true;
  bool _isSyncTime = false;
  BluetoothDeviceInfo foundDevice = null;
  Map<String, BluetoothDeviceInfo> foundDeviceList = {};
  void Start(BasePageState page, String MACAddress, bool isOpenDoor, Function onOpenDoorSuccess, Function onOpenDoorFailed, Function onCallBack) async{
    _context = page.context;
    _callerPage = page;
    _isOpenDoor = isOpenDoor;
    _isSyncTime = false;
    _searchMACAddress = MACAddress.toLowerCase();
    OnOpenDoorSuccess = onOpenDoorSuccess;
    OnOpenDoorFailed = onOpenDoorFailed;
    OnCallback = onCallBack;
    bOpenedAlertDlg = false;
    BluetoothState state = await flutterBlue.state;
    if (state == BluetoothState.on) {
      scan();
    }
    else
    {
      if(!bOpenedAlertDlg)
        utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
      bOpenedAlertDlg = true;
      cleanDeviceList();
      _callerPage.displayProgressIndicator(false);
      if(onOpenDoorFailed!=null)
        onOpenDoorFailed();
    }
    _stateSubscription = flutterBlue.onStateChanged().listen((s) {
      if (s == BluetoothState.on) {
        scan();
      }
      else
      {
        if(!bOpenedAlertDlg)
          utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
        bOpenedAlertDlg = true;
        cleanDeviceList();
        _callerPage.displayProgressIndicator(false);
        if(onOpenDoorFailed!=null)
          onOpenDoorFailed();
      }
    });
  }
  void SyncTime(BasePageState page, String MACAddress) async{
    _context = page.context;
    _callerPage = page;
    _isSyncTime = true;
    _searchMACAddress = MACAddress.toLowerCase();
    bOpenedAlertDlg = false;
    BluetoothState state = await flutterBlue.state;
    if (state == BluetoothState.on) {
      scan();
    }
    else
    {
      if(!bOpenedAlertDlg)
        utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
      bOpenedAlertDlg = true;
      cleanDeviceList();
      _callerPage.displayProgressIndicator(false);
    }
    _stateSubscription = flutterBlue.onStateChanged().listen((s) {
      if (s == BluetoothState.on) {
        scan();
      }
      else
      {
        if(!bOpenedAlertDlg)
          utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
        bOpenedAlertDlg = true;
        cleanDeviceList();
        _callerPage.displayProgressIndicator(false);
      }
    });
  }
  void RetrievePassword(BluetoothCharacteristic characteristic) async{
    
    IOTDeviceRealTimeInfoModel request = new IOTDeviceRealTimeInfoModel();
    request.IsOpenHook = !_isOpenDoor;
    request.DeviceMACAddress = foundDevice.DeviceMACAddress;
    request.DeviceLongitude = 0;
    request.DeviceLatitude = 0;
    request.DoorStatus = 0;
    request.PowerPercentage = 0;
    foundDevice.Password = '';
    var res = await UserServerApi().RetrieveIOTDevicePassword(_context, request);
    if(res==null)
    {
      utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["message"],_localizedValues[getLocaleCode()]["not_on_time"]);
      stopFoundDevice();
      _callerPage.displayProgressIndicator(false);
      return;
    }

    IoTDeviceTokenModel response = res;
    if(response.Password!="")
    {
      foundDevice.Password = response.Password;
      utility.OpenLockerDoor(foundDevice.device,characteristic, response.Password);
    }
  }
  void connectNextDevice()
  {
    if(foundDevice.DeviceMACAddress!='' && foundDevice.DeviceMACAddress==_searchMACAddress)
    {
      connectDevice(foundDevice.device, '');
    }
    else
    {
      if(foundDevice.DeviceMACAddress!='')
      {
        invalidDeviceIdList.add(foundDevice.Key);
        foundDeviceList.remove(foundDevice.Key);
      }
      connectDevice(null, foundDevice.Key);
    }
  }
  void listenStateChange(s) async
  {
    if(foundDevice==null)
    {
      connectDevice(null,'');
      return;
    }
    foundDevice.isConnected = s == BluetoothDeviceState.connected;
    if (!foundDevice.isConnected)
    {
      if(foundDevice.DeviceMACAddress!='' && foundDevice.DeviceMACAddress==_searchMACAddress)
      {
        stopFoundDevice();
        if(!bOpenedAlertDlg) {
          utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["message"],_localizedValues[getLocaleCode()]["warning_device_disconnected"]);
        }
        bOpenedAlertDlg = true;
        stop();
        _callerPage.displayProgressIndicator(false);
      }
      else
        connectNextDevice();
      return;
    }
    else
    {
      var services = await foundDevice.device.discoverServices();
      foundDevice.characteristic = utility.FindValidBluetoothCharacteristic(services);
      if(foundDevice.DeviceMACAddress=='')
        utility.RequestMACAddress(foundDevice.device, foundDevice.characteristic);
      else if(foundDevice.DeviceMACAddress==_searchMACAddress)
      {
        if(_isSyncTime)
          utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
        else
          RetrievePassword(foundDevice.characteristic);
      }
      else
      {
        connectNextDevice();
        return;
      }
      foundDevice.device.setNotifyValue(foundDevice.characteristic, true);
      foundDevice.device.onValueChanged(foundDevice.characteristic).listen((value) async{
        LockerResponse cmd = utility.parseSmartLockerResponse(foundDevice, value);
        switch(cmd.Command)
        {
          case 0x00:
            {
              int ret = int.parse('0x'+cmd.Value);
              if(ret==0)
                _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["sync_time_failed"]);
              else
                _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["sync_time_success"]);
              _callerPage.displayProgressIndicator(false);
            }
            break;
          case 0x03:
            {
              int ret = int.parse('0x'+cmd.Value);
              utility.RequestBattery(foundDevice.device, foundDevice.characteristic);
              if(ret==0)
              {
                if(OnOpenDoorFailed==null)
                  _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["unlocking_failed"]);
                else {
                  OnOpenDoorFailed(foundDevice==null?'':foundDevice.Password);
                }
                  
                ////utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
                ////RetrievePassword(foundDevice.characteristic);
              }
              else
              {
                if(OnOpenDoorSuccess==null)
                  _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["unlocking_success"]);
                else
                  OnOpenDoorSuccess();
              }
            }
            break;
          case 0x04:
            {
              foundDevice.DeviceMACAddress = cmd.Value;
              if(foundDevice.DeviceMACAddress==_searchMACAddress)
              {
                if(_isSyncTime)
                  utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
                else
                  RetrievePassword(foundDevice.characteristic);
              }
              else
              {
                connectNextDevice();
              }
            }
            break;
          case 0x05:
            {
              int uuid = int.parse('0x'+cmd.Value);
              String strUUID = uuid.toString();
            }
            break;
          case 0x07:
            {
              foundDevice.PowerPercentage = int.parse('0x'+cmd.Value).toDouble();
              IOTDeviceRealTimeInfoModel request = new IOTDeviceRealTimeInfoModel();
              request.DeviceLatitude = 0;
              request.DeviceLongitude = 0;
              request.DeviceMACAddress = foundDevice.DeviceMACAddress;
              request.PowerPercentage = foundDevice.PowerPercentage;
              request.DoorStatus = foundDevice.DoorStatus;
              request.IsOpenHook = !_isOpenDoor;
              await UserServerApi().UpdateIoTDeviceRealTimeInfo(_context, request);
              _callerPage.displayProgressIndicator(false);
              if(OnCallback!=null)
                OnCallback();
              ////utility.RequestDoorStatus(foundDevice.device, foundDevice.characteristic);
            }
            break;
          default:
            break;
        }
      });

    }
  }
  void listDeivceConnect(e)
  {
    foundDevice.isConnected = e == BluetoothDeviceState.connected;
    if(!foundDevice.isConnected)
    {
      if(foundDevice.DeviceMACAddress!='' && foundDevice.DeviceMACAddress==_searchMACAddress)
      {
        stopFoundDevice();
        utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["message"],_localizedValues[getLocaleCode()]["warning_device_disconnected"]);
        stop();
        _callerPage.displayProgressIndicator(false);
      }
      else
        connectNextDevice();
    }
  }
  void connectDevice(device, currentDeviceKey){
    if(foundDevice!=null)
      stopFoundDevice();
    if(device==null)
    {
      for(var item in foundDeviceList.values)
      {
        if((item.Key!=currentDeviceKey) && (invalidDeviceIdList.indexOf(item.Key)<0))
        {
          device = item.device;
          break;
        }
      }
    }
    if(device!=null)
    {
      foundDevice = new BluetoothDeviceInfo();
      foundDevice.DoorStatus = -1;
      foundDevice.PowerPercentage = -1;
      foundDevice.Key = device.id.toString();
      foundDevice.device = device;
      foundDevice.deviceConnect = flutterBlue.connect(foundDevice.device).listen(listDeivceConnect);
      foundDevice.deviceStateSubscription = foundDevice.device.onStateChanged().listen(listenStateChange);
    }
    else
    {
      if(!bOpenedAlertDlg) {
        utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["message"],_localizedValues[getLocaleCode()]["warning_device_disconnected"]);
      }
      bOpenedAlertDlg = true;
      _callerPage.displayProgressIndicator(false);
    }
  }
  void scanResult(var scanResult)
  {
    if(!invalidDeviceIdList.contains(scanResult.device.id.toString()) && ((scanResult.device.name.toLowerCase() == "imlockbox") || (scanResult.device.name.toLowerCase() == "smartailocker")|| (scanResult.device.name.toLowerCase().startsWith("jdy-")))){
      if(foundDeviceList[scanResult.device.id.toString()]==null)
      {
        BluetoothDeviceInfo newDevice = new BluetoothDeviceInfo();
        newDevice.DeviceUniqueID = '';
        newDevice.DoorStatus = -1;
        newDevice.PowerPercentage = -1;
        newDevice.device = scanResult.device;
        newDevice.Key = scanResult.device.id.toString();
        foundDeviceList[newDevice.Key] = newDevice;
      }
      if(foundDevice==null)
        connectDevice(scanResult.device,'');
    }
  }
  void scan() async {
    if(foundDevice!=null && foundDevice.DeviceMACAddress==_searchMACAddress)
    {
      if(foundDevice.isConnected)
      {
        if(_isSyncTime)
          utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
        else
          RetrievePassword(foundDevice.characteristic);
      }
      else
        foundDevice.deviceConnect = flutterBlue.connect(foundDevice.device).listen(listDeivceConnect);
    }
    else
    {
      stopFoundDevice();
      stop();
      scanSubscription = flutterBlue.scan().listen(scanResult);
    }
  }
  void stopFoundDevice()
  {
    foundDevice?.ClearSubscription();
    foundDevice = null;
  }
  void cleanDeviceList()
  {
    stopFoundDevice();
    foundDeviceList.forEach((uuid, sub) => sub.ClearSubscription());
    foundDeviceList.clear();
    scanSubscription?.cancel();
    scanSubscription = null;
  }
  void stop() {
    cleanDeviceList();
    _stateSubscription?.cancel();
    _stateSubscription = null;
  }
}
class BluetoothLockersScanner {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  StreamSubscription _stateSubscription;
  StreamSubscription scanSubscription;
  BluetoothUtility utility = new BluetoothUtility();
  bool bOpenedAlertDlg = false;
  BasePageState _callerPage;
  BuildContext _context;
  Map<String, BluetoothDeviceInfo> foundDeviceList = {};
  Function OnFoundDevice, OnConnectedDevice, OnDeviceRegistered, OnDeviceOpened, OnOpenDoorSuccess, OnOpenDoorFailed, OnRequestPermission;
  void Start(BasePageState page, Function onFoundDevice, Function onOpenDoorSuccess, Function onOpenDoorFailed, Function onRequestPermission) async{
    _callerPage = page;
    _context = page.context;
    OnFoundDevice = onFoundDevice;
    OnOpenDoorSuccess = onOpenDoorSuccess;
    OnOpenDoorFailed = onOpenDoorFailed;
    OnRequestPermission = onRequestPermission;
    bOpenedAlertDlg = false;
    BluetoothState state = await flutterBlue.state;
    if (state == BluetoothState.on) {
      scan();
    }
    else
    {
      if(!bOpenedAlertDlg)
        utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
      bOpenedAlertDlg = true;
      stop();
      _callerPage.displayProgressIndicator(false);
    }
    _stateSubscription = flutterBlue.onStateChanged().listen((s) {
      if (s == BluetoothState.on) {
        scan();
      }
      else
      {
        if(!bOpenedAlertDlg)
          utility.showAlertDialog(_context,_localizedValues[getLocaleCode()]["bluetooth_is_off"],_localizedValues[getLocaleCode()]["open_bluetooth"]);
        bOpenedAlertDlg = true;
        stop();
        _callerPage.displayProgressIndicator(false);
      }
    });
  }

  Map<String, BluetoothDeviceInfo> GetFoundDeviceList()
  {
    return foundDeviceList;
  }
  void SetDeviceTime(BluetoothDeviceInfo foundDevice, Function onDoorOpened){
    utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
    OnDeviceOpened = onDoorOpened;
  }
  void OpenDeviceDoor(BluetoothDeviceInfo foundDevice, Function onDoorOpened) async{
    IOTDeviceRealTimeInfoModel request = IOTDeviceRealTimeInfoModel(DeviceMACAddress:foundDevice.DeviceMACAddress, DeviceUniqueId:foundDevice.DeviceUniqueID, IsOpenHook:false);
    var res = await UserServerApi().RetrieveIOTDevicePassword(_context, request);
    if(res!=null)
    {
      if(res.Password!=null)
      {
        utility.OpenLockerDoor(foundDevice.device, foundDevice.characteristic,res.Password);
        foundDevice.StatusId = 2;
        if(onDoorOpened!=null)
          onDoorOpened(foundDevice, 'Door Opened, Please find the lockbox');
      }
    } else {
      foundDevice.deviceConnect.cancel();
      _callerPage.displayProgressIndicator(false);
    }
  }

  Future<bool> RegisterDevice(BuildContext context, BluetoothDeviceInfo foundDevice, String DeviceName, String Description, String QRCode, Function onDeviceRegistered) async {
    var result = await utility.RegisterDevice(context, foundDevice.DeviceUniqueID, foundDevice.DeviceMACAddress, QRCode, DeviceName, Description,);
    foundDevice.Status = "Registered";
    foundDevice.StatusId = 3;
    if(onDeviceRegistered!=null) {
      onDeviceRegistered(foundDevice, _localizedValues[getLocaleCode()]["device_regisgtered"]);
    }
    return result;
  }

  void ConnectDevce(BluetoothDeviceInfo foundDevice, Function onConnectedDevice) async{
    if(foundDevice==null || foundDevice.device==null)
    {
      if(foundDevice!=null)
      {
        foundDevice.ClearSubscription();
        foundDeviceList.remove(foundDevice.Key);
      }
      return;
    }
    OnConnectedDevice = onConnectedDevice;
    foundDevice.deviceConnect = flutterBlue.connect(foundDevice.device).listen((e){
      foundDevice.isConnected = e == BluetoothDeviceState.connected;
    });
    foundDevice.deviceStateSubscription = foundDevice.device.onStateChanged().listen((s) async{
      if(foundDevice == null) {
        return;
      }
      foundDevice.isConnected = s == BluetoothDeviceState.connected;
      if (foundDevice.isConnected && foundDevice.device != null) {
        var services = await foundDevice.device.discoverServices();
        if(foundDevice == null) {
          return;
        }
        foundDevice.characteristic = utility.FindValidBluetoothCharacteristic(services);
        if(foundDevice.DeviceMACAddress=='')
          utility.RequestMACAddress(foundDevice.device, foundDevice.characteristic);
        else
          utility.RequestDeviceUUID(foundDevice.device, foundDevice.characteristic);
        foundDevice.device.setNotifyValue(foundDevice.characteristic, true);
        foundDevice.device.onValueChanged(foundDevice.characteristic).listen((value) async{
          LockerResponse cmd = utility.parseSmartLockerResponse(foundDevice, value);
          switch(cmd.Command)
          {
            case 0x00:
              OpenDeviceDoor(foundDevice, this.OnDeviceOpened);
              break;
            case 0x03:
              {
                int ret = int.parse('0x'+cmd.Value);
                utility.RequestBattery(foundDevice.device, foundDevice.characteristic);
                if(ret==0)
                {
                  if(OnOpenDoorFailed==null)
                    _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["unlocking_failed"]);
                  else
                    OnOpenDoorFailed(foundDevice==null?'':foundDevice.Password);
                  ////utility.SetDeviceTime(foundDevice.device, foundDevice.characteristic);
                  ////RetrievePassword(foundDevice.characteristic);
                }
                else
                {
                  if(OnOpenDoorSuccess==null)
                    _callerPage.showToastMessage(_context, _localizedValues[getLocaleCode()]["unlocking_success"]);
                  else
                    OnOpenDoorSuccess();
                }
              }
              break;
            case 0x04:
              {
                foundDevice.DeviceMACAddress = cmd.Value;
                var res = await UserServerApi().SearchIoTDevices(_context,IOTDeviceInfoSearch(PageIndex: 0, PageSize: 50, DeviceMACAddress: foundDevice.DeviceMACAddress));
                if(res!=null && res.TotalCount>0)
                {
                  if(foundDevice.deviceConnect!=null)
                    foundDevice.deviceConnect.cancel();
                  foundDevice.Status = "Registered";
                  foundDevice.StatusId = 3;
                  if(OnFoundDevice!=null)
                    OnFoundDevice(foundDevice, _localizedValues[getLocaleCode()]["device_regisgteredbefore"]);
                }
                else
                {
                  utility.RequestDeviceUUID(foundDevice.device, foundDevice.characteristic);
                }
              }
              break;
            case 0x05:
              {
                int uuid = int.parse('0x'+cmd.Value);
                String strUUID = uuid.toString();
                foundDevice.DeviceUniqueID = strUUID;
                foundDevice.Status = "Connected";
                foundDevice.StatusId = 1;
                if(OnConnectedDevice!=null)
                  OnConnectedDevice(foundDevice, 'Device Connected!');
              }
              break;
          /*
          case 0x06:
            {
              foundDevice.DoorStatus = int.parse('0x'+cmd.Value);
              if(foundDevice.PowerPercentage>=0)
              {
                IOTDeviceRealTimeInfoModel request = new IOTDeviceRealTimeInfoModel();
                request.DeviceLatitude = 0;
                request.DeviceLongitude = 0;
                request.DeviceMACAddress = foundDevice.DeviceMACAddress;
                request.PowerPercentage = foundDevice.PowerPercentage;
                request.DoorStatus = foundDevice.DoorStatus;
                request.IsOpenHook = false;
                UserServerApi().UpdateIoTDeviceRealTimeInfo(request);
              }
            }
            break;
            */
            case 0x07:
              {
                foundDevice.PowerPercentage = int.parse('0x'+cmd.Value).toDouble();
                IOTDeviceRealTimeInfoModel request = new IOTDeviceRealTimeInfoModel();
                request.DeviceLatitude = 0;
                request.DeviceLongitude = 0;
                request.DeviceMACAddress = foundDevice.DeviceMACAddress;
                request.PowerPercentage = foundDevice.PowerPercentage;
                request.DoorStatus = foundDevice.DoorStatus;
                request.IsOpenHook = false;
                UserServerApi().UpdateIoTDeviceRealTimeInfo(_context, request);
                ////utility.RequestDoorStatus(foundDevice.device, foundDevice.characteristic);
              }
              break;
            default:
              break;
          }
        });
      }
    });
  }
  void scan() async {
    scanSubscription = flutterBlue.scan().listen((scanResult){
      if((scanResult.device.name.toLowerCase() == "imlockbox") || (scanResult.device.name.toLowerCase() == "smartailocker")|| (scanResult.device.name.toLowerCase().startsWith("jdy-"))){
        if(foundDeviceList[scanResult.device.id.toString()]==null)
          {
            BluetoothDeviceInfo foundDevice = new BluetoothDeviceInfo();
            foundDevice.DeviceUniqueID = '';
            foundDevice.DoorStatus = -1;
            foundDevice.PowerPercentage = -1;
            foundDevice.device = scanResult.device;
            foundDevice.Key = scanResult.device.id.toString();
            foundDeviceList[foundDevice.Key] = foundDevice;
            if(OnFoundDevice!=null)
              OnFoundDevice(foundDevice, _localizedValues[getLocaleCode()]["device_found"]);
          }
      }
    });
  }
  void cleanDeviceList()
  {
    foundDeviceList.forEach((uuid, sub) => sub.ClearSubscription());
    foundDeviceList.clear();
    scanSubscription?.cancel();
    scanSubscription = null;
  }
  void stop() {
    cleanDeviceList();
    _stateSubscription?.cancel();
    _stateSubscription = null;
  }
}