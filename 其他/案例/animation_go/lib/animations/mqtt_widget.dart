import 'dart:async';
import 'package:animation_go/mqtt/mqtt_event_bus.dart';
import 'package:animation_go/mqtt/mqtt_tool.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';

class MqttDemo extends StatefulWidget {
  @override
  _MqttDemoState createState() => _MqttDemoState();
}

class _MqttDemoState extends State<MqttDemo> {
  late StreamSubscription<List<MqttReceivedMessage<MqttMessage>>> _listenSubscription;
  late StreamSubscription<Map<dynamic, dynamic>> _listEvenBusSubscription;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: RaisedButton(
              onPressed: _connect,
              child: Text(
                "connect 连接",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _subscribeTopic,
              child: Text(
                "subscribe topic:订阅主题",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _unSubscribeTopic,
              child: Text(
                "unSubscribe topic：取消订阅",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _publishTopic,
              child: Text(
                "publish topic：发送一条数据",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _startListen,
              child: Text(
                "start listen：开始监听",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
          Container(
            child: RaisedButton(
              onPressed: _disconnect,
              child: Text(
                "disconnect：取消连接",
                style: TextStyle(fontSize: 20, color: Colors.purple),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  建立连接
  _connect() async {
    String server = "broker.emqx.io"; //
    int port = 1883; //
    String clientIdentifier = "flutter_client";
    String userName = "zst";
    String password = "zst";
    MqttTool.getInstance().connect(server, port, clientIdentifier, userName, password).then((v) {
      print('连接判断');
      print(v);
      if (v.returnCode == MqttConnectReturnCode.connectionAccepted) {
        print("恭喜你~ ====mqtt连接成功");
      } else if (v.returnCode == MqttConnectReturnCode.badUsernameOrPassword) {
        print("有事做了~ ====mqtt连接失败 --密码错误!!!");
      } else {
        print("有事做了~ ====mqtt连接失败!!!");
      }
    });
  }

//  订阅主题
  _subscribeTopic() {
    String topic = "zst";
    MqttTool.getInstance().subscribeMessage(topic);
  }

//  取消订阅
  _unSubscribeTopic() {
    String topic = "zst";
    MqttTool.getInstance().unsubscribeMessage(topic);
  }

//  发布消息
  _publishTopic() {
    String topic = "zst";
    String str = "turn left 30";
    MqttTool.getInstance().publishMessage(topic, str);
  }

//  监听消息的具体实现
  _onData(List<MqttReceivedMessage<MqttMessage>> data) {
    final MqttMessage recMess = data[0].payload;
    final String topic = data[0].topic;
    // final String pt = Utf8Decoder().convert(recMess);
    String desString = "topic is <$topic>";
    print("string =$desString");
    Map p = Map();
    p["topic"] = topic;
    p["type"] = desString;
    p["payload"] = recMess;
    print(p);
    ListEventBus.getDefault().post(p);
  }

//  开启监听消息
  _startListen() {
    _listenSubscription = MqttTool.getInstance().updates()!.listen(_onData);
  }

//  断开连接
  _disconnect() {
    MqttTool.getInstance().disconnect();
  }
}
