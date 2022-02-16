
import 'package:flutter/material.dart';
import 'package:flutter_socket/ApiController.dart';
import 'package:flutter_socket/privatechat.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class RegisterStatefulWidget extends StatefulWidget {
  @override
  RegisterStateful createState() => RegisterStateful();
}

class RegisterStateful extends State<RegisterStatefulWidget> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtDOB = TextEditingController();
  TextEditingController cbSex = TextEditingController();

  int isErrorUsername = 0;
  int isErrorPassword = 0;
  int isErrorEmail = 0;

  void Register(username,password,sex,email,dob){
    API.Register(username, password, dob, sex).then(RegisterSuccess).onError(RegisterError);
  }
  void RegisterSuccess(value){
    Fluttertoast.showToast(
      msg:
      "Đăng ký thành công!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginPageStateful(txtUsername.value.text,txtPassword.value.text)),(r)=>false);
  }
  void RegisterError(error, stackTrace){
    Fluttertoast.showToast(
      msg:
      "Đăng ký không thành công vui lòng kiểm tra lại!",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }



  @override
  Widget build(BuildContext context) {
    // txtUsername.addListener(() {
    //   setState(() {
    //     isErrorUsername = txtUsername.value.text.isEmpty ? 1 : 0;
    //   });
    // });
    // txtPassword.addListener(() {
    //   setState(() {
    //     isErrorPassword = txtPassword.value.text.isEmpty ? 1 : 0;
    //   });
    // });
    // txtEmail.addListener(() {
    //   setState(() {
    //     isErrorEmail = txtEmail.value.text.isEmpty ? 1 : 0;
    //   });
    // });
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
                              "Đăng ký",
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
                              "Chào mừng bạn đến với ứng dụng của tôi",
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
                              obscureText: true,
                              controller: txtPassword,
                              style: TextStyle(
                                  backgroundColor:
                                      Color.fromARGB(255, 29, 28, 35),
                                  color: Colors.white),
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 29, 28, 35),
                                  suffixIcon: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 30, 0),
                                    child: new Icon(
                                      Icons.visibility,
                                      color: Color.fromARGB(255, 123, 119, 146),
                                      size: 30,
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
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 190,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextFormField(
                                    controller: cbSex,
                                    style: TextStyle(
                                        backgroundColor:
                                            Color.fromARGB(255, 29, 28, 35),
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 29, 28, 35),
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              200, 179, 174, 213),
                                        ),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(27, 22, 27, 22),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        hintText: 'Sex'),
                                  ),
                                ),
                                Container(
                                  width: 190,
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: TextFormField(
                                    controller: txtDOB,
                                    style: TextStyle(
                                        backgroundColor:
                                            Color.fromARGB(255, 29, 28, 35),
                                        color: Colors.white),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 29, 28, 35),
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              200, 179, 174, 213),
                                        ),
                                        contentPadding:
                                            EdgeInsets.fromLTRB(27, 22, 27, 22),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 50, 48, 58),
                                              width: 3.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        hintText: 'Date of birth'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  alignment: Alignment.centerLeft) ,
                              onPressed: () => {
                                Register(txtUsername.value.text,txtPassword.value.text,cbSex.value.text,"nguyenduong",txtDOB.value.text)
                              },
                              child: Container(
                                height: 70,
                                width: 828,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 59, 58, 65),
                                  borderRadius: BorderRadius.circular(25)
                                ),
                                child: Text(
                                  "Đăng ký",
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
                              "Bạn đã có tài khoản? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPageStateful("","")))
                                    },
                                child: Text(
                                  "Đăng nhập",
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
