import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_socket/UserInfoList.dart';
import 'package:flutter_socket/menu.dart';
import 'package:flutter_socket/privatechat.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'ApiController.dart';
import 'message.dart';

class SettingReportStateful extends StatefulWidget {

  User user;
  UserListInfor userTo;

  SettingReportStateful(this.user, this.userTo);

  @override
  SettingReportScreen createState() => SettingReportScreen(this.user, this.userTo);
}

class SettingReportScreen extends State<SettingReportStateful> {

  User user;
  UserListInfor userTo;


  SettingReportScreen(this.user, this.userTo);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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
                              user.data!.username!,
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
                              "Hãy cho tôi biết cản nhận của bạn về tôi",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(20, 150, 20, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "1",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "( 2 )",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "2",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "( 1 )",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "3",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "( 0 )",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "4",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "( 125 )",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "5",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Icon(
                                      Icons.star_outlined,
                                      color: Colors.white,
                                      size: 35,
                                    ),
                                    Text(
                                      "( 50 )",
                                      style: GoogleFonts.sourceSansPro(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Người dùng trên có khiến bạn cảm thấy khó chịu không?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50, 30),
                                    alignment: Alignment.centerLeft),
                                onPressed: () => {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => UserlistStateful(userlogin,1990,2010,-1)))
                                },
                                child: Container(
                                  height: 70,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 58, 65),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    "Báo cáo người dùng",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size(50, 30),
                                    alignment: Alignment.centerLeft),
                                onPressed: () => {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => UserlistStateful(userlogin,1990,2010,-1)))
                                },
                                child: Container(
                                  height: 70,
                                  width: 200,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 58, 65),
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Text(
                                    "Chặn người dùng",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )


                          ],
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