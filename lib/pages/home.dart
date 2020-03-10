import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const int _AppBarScrollOffset = 100;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => (_HomeState());
}

class _HomeState extends State<Home> {
  List<String> _swiperUrls = [
    "http://cdn2.image.apk.gfan.com/asdf/PImages/2012/2/5/224702_219ba9e6b-4425-428f-b5e8-816d7aafd8cd.jpg",
    "http://a2.att.hudong.com/08/72/01300000165476121273722687045.jpg",
    "http://a4.att.hudong.com/21/09/01200000026352136359091694357.jpg"
  ];
//  WebSocketChannel channel;
  @override
  initState(){
    super.initState();
//    channel = new IOWebSocketChannel.connect('http://127.0.0.1:8080/ws') ;
  }
  void _sendMessage() {
//    if (_controller.text.isNotEmpty) {
//      widget.channel.sink.add(_controller.text);
//    }
//    channel.sink.add("hah");
  }
  @override
  void dispose() {
//    channel.sink.close();
    super.dispose();
  }
  double appBarAlpha = 0;
  _scroll(offset) {
    double alpha = offset / _AppBarScrollOffset;
    if (alpha > 1) {
      alpha = 1;
    } else if (alpha < 0) {
      alpha = 0;
    }
    setState(() {
      appBarAlpha = alpha ;
//      channel.sink.add(alpha);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: Stack(
              children: <Widget>[
                NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        _scroll(scrollNotification.metrics.pixels);
                      }
                      return true;
                    },
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 160,
                          child: Swiper(
                            itemCount: _swiperUrls.length,
                            autoplay: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                _swiperUrls[index],
                                fit: BoxFit.fill,
                              );
                            },
                            pagination: new SwiperPagination(),
                            // control: new SwiperControl(),
                          ),
                        ),
                        Container(
                          height: 1000,
                          child: ListTile(title: Text('haha')),
                        ),
                      ],
                    )),
                Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                      height: 80,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text('首页'),
                      ))),
                ),

              ],
            )));
  }
}
