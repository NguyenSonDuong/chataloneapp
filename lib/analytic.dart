
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/ApiController.dart';
import 'package:flutter_socket/infouser.dart';
import 'package:flutter_socket/setting.dart';
import 'package:flutter_socket/user.dart';
import 'package:flutter_socket/userlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AnalyticStateful extends StatefulWidget {
  User userlogin;

  AnalyticStateful(this.userlogin);

  @override
  AnalyticScreen createState() {
    return AnalyticScreen(this.userlogin);
  }
}

class AnalyticScreen extends State<AnalyticStateful> {
  User userlogin;

  double point = 0;

  int oneStart = 0;
  int twoStart = 0;
  int threeStart = 0;
  int fourStart = 0;
  int fiveStart = 0;

  void GetEvalute(){
    API.GetEvaluate(userlogin.token!, userlogin.data!.username!).then((value){
      try{
        EvaluteResponsive evaluteResponsive = EvaluteResponsive.fromJson(jsonDecode(value));
        double count = 0.0;
        double pointTemb = 0.0;
        for(var e in evaluteResponsive.content! ){
          count+=1.0;
          pointTemb+=e.point!;
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
        setState(() {
          point = pointTemb/count;
        });
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



  AnalyticScreen(this.userlogin);


  @override
  void initState() {
    super.initState();
    GetEvalute();
  }

  @override
  Widget build(BuildContext context) {
    String? username = userlogin.data?.username;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 23, 31),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Chào mừng",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: ()=>{
                          Navigator.pop(context)
                        },
                        child: Text(
                          username!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(6),
                      child: Text(
                        "Thông tin của bạn sẽ được bảo mật tuyệt đối!",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(children: [
                        Text(
                          "Thông tin tài khoản",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Color.fromARGB(255, 59, 58, 65)
                          ),
                          child:Text(
                            "Điểm: ${point}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 59, 58, 65)
                          ),
                          child:Text(
                            "Số người nhắn tin: 0",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color.fromARGB(255, 59, 58, 65)
                          ),
                          child:Text(
                            "Tỉ lệ phản hồi chat: 0",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 70),
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
    );
  }
}
