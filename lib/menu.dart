
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/infouser.dart';
import 'package:flutter_socket/user.dart';
import 'package:flutter_socket/userlist.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuStateful extends StatefulWidget {
  User userlogin;

  MenuStateful(this.userlogin);

  @override
  MenuScreen createState() {
    return MenuScreen(this.userlogin);
  }
}

class MenuScreen extends State<MenuStateful> {
  User userlogin;

  MenuScreen(this.userlogin);

  @override
  Widget build(BuildContext context) {
    String? username = userlogin.data?.username;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 23, 31),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoUserStatesfull(userlogin)))
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
                        "Hôm nay của bạn thế nào? Mọi chuyện vẫn ổn chứ?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w100),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "images/funny.png",
                                width: 40,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  "Vui",
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "images/nomail.png",
                                width: 40,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  "Bình thường",
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "images/sad.png",
                                width: 40,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Text(
                                  "Buồn",
                                  style: GoogleFonts.sourceSansPro(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Column(
                        children: [
                          Text(
                            "Không ai buồn mãi về chuyện quá khứ...",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          ),
                          Text(
                            "Tác giả: Vô Danh",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w100),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 50, 20, 30),
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size(50, 30),
                      alignment: Alignment.centerLeft),
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserlistStateful(userlogin,1990,2010,-1)))
                  },
                  child: Container(
                    height: 70,
                    width: 828,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 59, 58, 65),
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      "Tìm kiến người dùng",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
