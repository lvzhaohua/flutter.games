import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: _buildBody(), // 构建主页面
//      drawer: MyDrawer(), //抽屉菜单
    );
  }

  Widget _buildBody() {
    return new Center(
      child: GestureDetector(
        onTap: _toLogin,
          child: new Text('Hello World')),
    );
  }
  _toLogin(){
    Navigator.of(context).pushNamed("login");
  }

  Widget MyDrawer() {
    return Text("MyDrawer");
  }

  @override
  void initState() {
//    Navigator.of(context).pushNamed("login");
    super.initState();
  }
//  ...// 省略
}
