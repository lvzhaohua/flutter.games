import 'package:flutter/material.dart';
import 'package:web_socket_channel/html.dart';

class WS {
  WS([this.context]);

  BuildContext context;
  static HtmlWebSocketChannel _channel;

  static void init() {
    connect();
  }

  static connect() async {
    print('ws init');
    _channel = HtmlWebSocketChannel.connect('ws://127.0.0.1:8080/ws');
    _channel.sink.add('connect');
    _channel.stream.listen((event) {
      print('ws handle data');
      print(event);
    }, onDone: () {
      print('ws done');
    }, onError: (err) {
      print('ws error');
      print(err);
    });
  }

  static sendMessage(msg){
    _channel.sink.add(msg);
  }
  static dispose() {
    _channel.sink.close() ;
  }
}
