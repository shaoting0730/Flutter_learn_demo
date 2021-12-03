import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:typed_data/typed_buffers.dart';

typedef ConnectedCallback = void Function();

class MqttTool {
  MqttQos qos = MqttQos.atLeastOnce;
  late MqttServerClient mqttClient;
  static MqttTool _instance = MqttTool();
  static MqttTool getInstance() {
    if (_instance == null) {
      _instance = MqttTool();
    }
    return _instance;
  }

  Future connect(String server, int port, String clientIdentifier, String username, String password, {bool isSsl = false}) {
    print(server);
    print(port);
    print(clientIdentifier);
    print(username);
    print(password);

    mqttClient = MqttServerClient.withPort(server, clientIdentifier, port);

    mqttClient.onConnected = onConnected;

    mqttClient.onSubscribed = _onSubscribed;

    mqttClient.onSubscribeFail = _onSubscribeFail;

    mqttClient.logging(on: true); //设置是否登陆,这里设置为不验证帐号密码

    mqttClient.onUnsubscribed = (e) {};

    mqttClient.setProtocolV311();
    mqttClient.logging(on: false);
    if (isSsl) {
      mqttClient.secure = true;
      mqttClient.onBadCertificate = (dynamic a) => true;
    }
    _log("_正在连接中...");
    //     return mqttClient.connect();  //不使用用户名和密码直接使用connect()
    return mqttClient.connect(username, password);
  }

  disconnect() {
    mqttClient.disconnect();
    _log("_disconnect");
  }

  int publishMessage(String pTopic, String msg) {
    _log("_发送数据-topic:$pTopic,playLoad:$msg");
    Uint8Buffer uint8buffer = Uint8Buffer();
    var codeUnits = msg.codeUnits;
    uint8buffer.addAll(codeUnits);

    return mqttClient.publishMessage(pTopic, qos, uint8buffer, retain: false);
  }

  int publishRawMessage(String pTopic, List<int> list) {
    _log("_发送数据-topic:$pTopic,playLoad:$list");
    Uint8Buffer uint8buffer = Uint8Buffer();
//    var codeUnits = msg.codeUnits;
    uint8buffer.addAll(list);
    return mqttClient.publishMessage(pTopic, qos, uint8buffer, retain: false);
  }

  Subscription? subscribeMessage(String subtopic) {
    return mqttClient.subscribe(subtopic, qos);
  }

  unsubscribeMessage(String unSubtopic) {
    mqttClient.unsubscribe(unSubtopic);
  }

  MqttClientConnectionStatus? getMqttStatus() {
    return mqttClient.connectionStatus;
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? updates() {
    _log("_监听成功!");
    return mqttClient.updates;
  }

  onConnected() {
//    mqttClient.onConnected = callback;
    _log("_onConnected");
  }

  onDisConnected(ConnectedCallback callback) {
    mqttClient.onDisconnected = callback;
  }

  _onDisconnected() {
    _log("_onDisconnected");
  }

  _onSubscribed(String topic) {
    _log("_订阅主题成功---topic:$topic");
  }

  _onUnSubscribed(String topic) {
    _log("_取消订阅主题成功---topic:$topic");
  }

  _onSubscribeFail(String topic) {
    _log("_onSubscribeFail");
  }

  _log(String msg) {
    print("MQTT-->$msg");
  }
}
