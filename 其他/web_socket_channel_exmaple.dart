import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketMessage {
  late WebSocketChannel channel;
  // 创建一个WebSocketChannel，并连接到WebSocket服务器
  void initSocket() async {
    var uri = 'XXXXXXXXXXXXXXXXXX';
    channel = new IOWebSocketChannel.connect(uri);
    sendMessage();
    // 发送数据给 socket 测试服务器，为了能够收到测试服务器返回的数据（正常情况下不需要）
    channel.sink.add('发送测试消息');
  }

  // 监听socket服务器的状态，并对 成功、异常、断开 进行处理
  void sendMessage() {
    channel.stream.listen(onData, onError: onError, onDone: onDone);
  }

  // socket 链接断开以后重新初始化 socket
  void onDone() async {
    print('Socket is closed');
    initSocket();
  }

  // socket err 情况的处理
  void onError(err) {
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
  }

  // 收到服务端推送的消息event
  void onData(event) {
   print('收到消息 ${event}');
    // 这里可以做业务 
  }

  // 关闭WebSocket连接
  void dispose() {
    print('关闭Socket');
    channel.sink.close();
  }
}
