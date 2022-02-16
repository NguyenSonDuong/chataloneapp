import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/user.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoUserStatesfull extends StatefulWidget {
  User user;

  InfoUserStatesfull(this.user);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InfoUserState(user);
  }
}

class InfoUserState extends State<InfoUserStatesfull> {
  User user;

  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtDOB = TextEditingController();
  TextEditingController txtSex = TextEditingController();
  TextEditingController txtPassold = TextEditingController();
  TextEditingController txtPassRepe = TextEditingController();
  TextEditingController txtPassNew = TextEditingController();

  InfoUserState(this.user);

  @override
  Widget build(BuildContext context) {
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
                              "" + user.data!.username!,
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
                              "Thông tin của bạn sẽ được bảo mật tuyệt đối!",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Thông tin tài khoản:",
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Color.fromARGB(255, 59, 58, 65)),
                                  padding: EdgeInsets.all(0),
                                  child: TextButton(
                                      onPressed: () => {},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mode_edit_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                                  hintText: user.data!.username!),
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
                                    controller: txtSex,
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
                                        hintText: (user.data!.userInfo!.sex! > 0
                                            ? "Nam"
                                            : "Nữ")),
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
                                        hintText:
                                            '${user.data!.userInfo!.dateOfBirth}'),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mật khẩu:",
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Color.fromARGB(255, 59, 58, 65)),
                                  padding: EdgeInsets.all(0),
                                  child: TextButton(
                                      onPressed: () => {},
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.mode_edit_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: txtPassold,
                              obscureText: true,
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
                                  hintText: "Mật khẩu cũ"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: txtPassRepe,
                              obscureText: true,
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
                                  hintText: "Nhập lại mật khẩu cũ"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: TextFormField(
                              controller: txtPassNew,
                              obscureText: true,
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
                                  hintText: "Mật khẩu mới"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
