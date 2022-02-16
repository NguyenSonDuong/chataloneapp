import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/menu.dart';
import 'package:flutter_socket/privatechat.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart' as mainAll;
import 'ApiController.dart';

class LoginPageStateful extends StatefulWidget {

  String username ;
  String password;


  LoginPageStateful(this.username, this.password);

  @override
  LoginScreen createState() => LoginScreen(this.username, this.password);
}

class LoginScreen extends State<LoginPageStateful> {

  bool isErrorUsernameEmpty = false;
  bool isErrorPasswordEmpty = false;
  bool isErrorUsernameWrong = false;
  bool isErrorPasswordWrong = false;

  String username ;
  String password;

  late SharedPreferences prefs ;

  LoginScreen(this.username, this.password);

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    txtUsername.text = username;
    txtPassword.text = password;
  }

  void Login(value) async {

    Map<String, dynamic> data = jsonDecode(value);
    prefs = await SharedPreferences.getInstance();
    var user = User.fromJson(data);
    prefs.setString("username", user.data!.username!);
    prefs.setString("token",
        user.token!);
    await API.SetToken(user.token!, prefs.getString("tokenfb")!);
    Fluttertoast.showToast(
        msg:
        "Đăng nhập thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterStatefulWidget()))
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MenuStateful(user)),
        (r) => false);
  }

  void ClickLogin() {
    API.Login(txtUsername.value.text, txtPassword.value.text)
        .then( Login)
        .onError((error, stackTrace) => {
              Fluttertoast.showToast(
                  msg:
                      "Đăng nhập thất bại, vui lòng kiểm tra lại thông tin tài khoản",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0)
            });
  }

  bool isShow = true;
  void ShowPassword() {
    setState(() {
      isShow = !isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    txtUsername.addListener(() {
      setState(() {
        isErrorUsernameEmpty = txtUsername.value.text.isEmpty;
      });
    });
    txtPassword.addListener(() {
      setState(() {
        isErrorPasswordEmpty = txtPassword.value.text.isEmpty;
      });
    });
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 23, 31),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 30, 0, 0),
              child: TextButton(
                onPressed: () => {Navigator.pop(context)},
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(45, 45, 45, 0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Đăng nhập",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(6),
                            child: Text(
                              "Chào mừng bạn đã quay trở lại",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: TextFormField(
                              controller: txtUsername,
                              style: TextStyle(
                                  backgroundColor:
                                      Color.fromARGB(255, 29, 28, 35),
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 29, 28, 35),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(200, 179, 174, 213),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(27, 22, 27, 22),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  hintText: 'Email or username'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextFormField(
                              obscureText: isShow,
                              controller: txtPassword,
                              style: TextStyle(
                                  backgroundColor:
                                      Color.fromARGB(255, 29, 28, 35),
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 29, 28, 35),
                                  suffixIcon: TextButton(
                                    onPressed: () => {
                                      ShowPassword(),
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 20, 0),
                                      child: new Icon(
                                        Icons.visibility,
                                        color:
                                            Color.fromARGB(255, 123, 119, 146),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(200, 179, 174, 213),
                                  ),
                                  contentPadding:
                                      EdgeInsets.fromLTRB(27, 22, 27, 22),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 50, 48, 58),
                                        width: 3.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  hintText: 'Password'),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  alignment: Alignment.centerLeft),
                              onPressed: () => {ClickLogin()},
                              child: Container(
                                height: 70,
                                width: 828,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 59, 58, 65),
                                    borderRadius: BorderRadius.circular(25)),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có tài khoản? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegisterStatefulWidget()))
                                    },
                                child: Text(
                                  "Đăng ký",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(45, 0, 45, 45),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size(50, 30),
                                alignment: Alignment.centerLeft),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrivateStateful()))
                            },
                            child: Container(
                              height: 70,
                              width: 828,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(
                                "Người dùng ẩn danh",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 24, 23, 31),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
