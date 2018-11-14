import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_todolist/util/Api.dart';
import 'package:flutter_todolist/util/NetUtil.dart';
import 'dart:convert';
import 'package:flutter_todolist/bean/LoginInfo.dart';

/// 登陆注册界面
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new LoginPageWidget(),
    );
  }
}

class LoginPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LoginPageState();
  }
}

class LoginPageState extends State<LoginPageWidget> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Column(
        children: <Widget>[
//          new MyAppBar(), // 这个是测试着玩的
          new Expanded(child: new _BodyContent()),
        ],
      ),
    );
  }
}

class _BodyContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new BodyContentState();
  }
}

class BodyContentState extends State<_BodyContent> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController pwdNameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
//      decoration: new BoxDecoration(color: Colors.blue),
      width: double.infinity,
      child: new Column(
        children: <Widget>[
          new Expanded(
              child: new Container(
            constraints: new BoxConstraints.expand(
              height: 300,
              width: 300,
            ),
            decoration: new BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/checklist_128.png'),
                ),
//                color: Colors.cyan,
                borderRadius: BorderRadius.circular(30.0)),
          )),
          new Expanded(
            child: new Container(
              padding: EdgeInsets.only(left: 20),
              margin: EdgeInsets.all(20),
              child: new Column(
                children: <Widget>[
                  // 账号
                  new Row(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[new Text('用户名:')],
                      ),
                      new Expanded(
                          child: new Container(
                              margin: EdgeInsets.only(left: 20),
                              child: new TextField(
                                controller: userNameController,
                                decoration:
                                    new InputDecoration(hintText: '输入用户名'),
                              )))
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[new Text('密  码:')],
                      ),
                      new Expanded(
                        child: new Container(
                          margin: EdgeInsets.only(left: 20),
                          child: new TextField(
                            controller: pwdNameController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: new InputDecoration(hintText: '输入用密码'),
                          ),
                        ),
                      )
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Center(
                        child: new Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 20),
                          width: double.infinity,
                          child: new RaisedButton(
                              onPressed: _login,
                              color: Colors.blue[400],
                              child: new Text('登录',
                                  style: new TextStyle(color: Colors.white))),
                        ),
                      ))
                    ],
                  ),

                  /// 忘记密码和注册账号
                  new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new Center(
                          child: new GestureDetector(
                            onTap: _register,
                            child: new Text('注册账号'),
                          ),
                        ),
                        flex: 2,
                      ),
                      new Expanded(
                        child: new Center(
                          child: new Text('忘记密码'),
                        ),
                        flex: 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _login() async {
    var userName = userNameController.text;
    var pwd = pwdNameController.text;

    if (userName.length == 0 || pwd.length == 0) {
      _showSnackBar('用户名或者密码不能为空');
    } else {
      //登录

//      Dio dio = new Dio();
//      Response response = await dio.get("http://wanandroid.com/wxarticle/chapters/json");
//      _showSnackBar(response.data.toString());

      Map<String, String> map = new Map();
      map["username"] = userName;
      map["password"] = pwd;
      Dio dio = new Dio();
      Response response = await dio.post(Api.loginUrl, data: map);
      _showSnackBar(response.data.toString());

//    Map<String,String> map = new Map();
//    map["username"] = "zhanganran";
//    map["password"] = "ef123456";
//
//      NetUtil.post(
//          Api.loginUrl,
//          (data) {
//            _showSnackBar(data.toString());
//          },
//          params: map,
//          errorCallBack: (errorMsg) {
//            _showSnackBar(errorMsg);
//          });
    }
  }

  void _showAlertDialog(String meg) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text(meg),
          );
        });
  }

  void _showSnackBar(String meg) {
    final snackBar = new SnackBar(content: new Text(meg));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _register() async {
    String userName = userNameController.text;
    String pwd = pwdNameController.text;

    try {
      if (userName.length == 0 || pwd.length == 0) {
        _showSnackBar('用户名或者密码不能为空');
      } else {
        //注册
        Response response;
        var exception;
        try {
          Map<String, String> map = new Map();
          map["username"] = userName;
          map["password"] = pwd;
          map["repassword"] = pwd;
          Dio dio = new Dio();
          response = await dio.post(Api.registerUrl, data: map);
        } catch (e) {
          print(e);
          exception = e;
        } finally {
          _showSnackBar("error：" + exception.toString());
        }
      }
    } catch (e) {
      print(e);
    }
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      // 实现padding
      height: 88,
      padding: EdgeInsets.only(top: 40.0),
      decoration: new BoxDecoration(color: Colors.pinkAccent),
      // 水平线性布局
      child: new Row(
        children: <Widget>[
          new IconButton(icon: new Icon(Icons.menu), onPressed: null),
          new Expanded(
              child: new Center(
            child: new Text(
              '我自横刀向天笑',
              style: new TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          )),
          new IconButton(icon: new Icon(Icons.search), onPressed: null)
        ],
      ),
    );
  }
}
