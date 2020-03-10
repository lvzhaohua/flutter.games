import 'package:app/common/global.dart';
import 'package:app/common/net/ws.dart';
import 'package:app/models/index.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:toast/toast.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginRouteState();
  }
}

class LoginRouteState extends State<LoginRoute> {
  bool _loading = false;
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //密码是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              loadingWidget(),
              TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: '用户名',
                    hintText: '用户名',
                    prefixIcon: Icon(Icons.person),
                  ),
                  // 校验用户名（不能为空）
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : '用户名不能为空';
                  }),
              TextFormField(
                controller: _pwdController,
                autofocus: !_nameAutoFocus,
                decoration: InputDecoration(
                    labelText: '密码',
                    hintText: '密码',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          pwdShow ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          pwdShow = !pwdShow;
                        });
                      },
                    )),
                obscureText: !pwdShow,
                //校验密码（不能为空）
                validator: (v) {
                  return v.trim().isNotEmpty ? null : '密码不能为空';
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text('登录'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showLoading(bool show) {
    setState(() {
      _loading = show;
    });
  }

  Widget loadingWidget () {
    if (_loading) {
      return JumpingDotsProgressIndicator(
        fontSize: 20.0,
      ) ;
    }
    return Container() ;
  }

  _showToast(msg) {
    Toast.show(msg, context, duration: Toast.LENGTH_LONG);
  }

  _onLogin() async {
    // 提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      _showLoading(true);
      User user;
      try {
//        user = await Git(context)
//            .login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
//        Provider.of<UserModel>(context, listen: false).user = user;
        var loginRequest  = LoginRequest.create();
        loginRequest.userName =_unameController.text ;
        loginRequest.password = _pwdController.text;
        WS.sendMessage(loginRequest);
        new Future.delayed(Duration(seconds: 3)).then((value) {
          _showLoading(false);
          _showToast('登录成功');
        });
      } catch (e) {
        //登录失败则提示
        if (e.response?.statusCode == 401) {
          _showToast('账号密码错误');
        } else {
          _showToast(e.toString());
        }
      } finally {
        // 隐藏loading框
//        _showLoading(false);
//        Navigator.of(context).pop();
      }
      if (user != null) {
        // 返回
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    WS.dispose();
    super.dispose();
  }
}
