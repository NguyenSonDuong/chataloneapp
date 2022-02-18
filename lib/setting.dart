import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_socket/UserInfoList.dart';
import 'package:flutter_socket/menu.dart';
import 'package:flutter_socket/privatechat.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  int oneStart = 0;
  int twoStart = 0;
  int threeStart = 0;
  int fourStart = 0;
  int fiveStart = 0;

  void GetEvalute(){
    API.GetEvaluate(user.token!, userTo.username!).then((value){
      try{
        EvaluteResponsive evaluteResponsive = EvaluteResponsive.fromJson(jsonDecode(value));
        for(var e in evaluteResponsive.content! ){
          if(e.point == 1.0){
            setState(() {
              oneStart++;
            });
          }
          if(e.point == 2.0){
            setState(() {
              twoStart++;
            });
          }
          if(e.point == 3.0){
            setState(() {
              threeStart++;
            });
          }
          if(e.point == 4.0){
            setState(() {
              fourStart++;
            });
          }
          if(e.point == 5.0){
            setState(() {
              fiveStart++;
            });
          }
        }

      }catch(e){
        Fluttertoast.showToast(
            msg:
            "Lỗi không xác định vui lòng kiểm tra lại kết nối internet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(
          msg:
          "Lỗi không xác định vui lòng kiểm tra lại kết nối internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }


  void BlockUser(){

      API.SetBlock(user.token, userTo.username).then((value) {
        Fluttertoast.showToast(
            msg:
            "Chặn người dùng thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg:
            "Chặn người dùng thất bại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      });
  }

  void AddRanker( int point){

      API.SetEvaluate(user.token, userTo.username!, point).then((value) {
        Fluttertoast.showToast(
            msg:
            "Đánh giá người dùng thành công",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg:
            "Đánh giá không thành công vui lòng thử lại",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white,
            fontSize: 16.0);
      });


  }

  SettingReportScreen(this.user, this.userTo);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetEvalute();
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "1",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          AddRanker(1);
                                        },
                                        child: Icon(
                                          Icons.star_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "( ${oneStart} )",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "2",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          AddRanker(2);
                                        },
                                        child: Icon(
                                          Icons.star_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "( ${twoStart} )",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "3",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          AddRanker(3);
                                        },
                                        child: Icon(
                                          Icons.star_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "( ${threeStart} )",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "4",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          AddRanker(4);
                                        },
                                        child: Icon(
                                          Icons.star_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "( ${fourStart} )",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "5",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          AddRanker(5);
                                        },
                                        child: Icon(
                                          Icons.star_outlined,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                      ),
                                      Text(
                                        "( ${fiveStart} )",
                                        style: GoogleFonts.sourceSansPro(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
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
                            Expanded(
                              child: Container(
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
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
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
                            ),
                            Expanded(
                              child: Container(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(50, 30),
                                      alignment: Alignment.centerLeft),
                                  onPressed: () {
                                    BlockUser();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.fromLTRB(15, 25, 15, 25),
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

class EvaluteResponsive {
  String? createAt;
  String? message;
  List<Content>? content;

  EvaluteResponsive({this.createAt, this.message, this.content});

  EvaluteResponsive.fromJson(Map<String, dynamic> json) {
    createAt = json['create_at'];
    message = json['message'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_at'] = this.createAt;
    data['message'] = this.message;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? idUserEvaluate;
  double? point;

  Content(
      {this.id,
        this.deleted,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.idUserEvaluate,
        this.point});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    idUserEvaluate = json['idUserEvaluate'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['idUserEvaluate'] = this.idUserEvaluate;
    data['point'] = this.point;
    return data;
  }
}