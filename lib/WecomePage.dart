
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/register.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class WecomeStateful extends StatefulWidget {
  @override
  WecomeState createState() => WecomeState();
}

class WecomeState extends State<WecomeStateful> {
  var isRegisterCLick = true;
  var isLoginCLick = false;

  void clickRegister() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterStatefulWidget()));
    setState(() {
      isRegisterCLick = true;
      isLoginCLick = false;
    });
  }

  void clickLogin() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPageStateful("","")));
    setState(() {
      isRegisterCLick = false;
      isLoginCLick = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 23, 31),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  Container(
                    child: Image.asset("images/imagewecomeview.png",
                        width: MediaQuery.of(context).size.width),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(45, 15, 45, 0),
                    child: Column(
                      children: [
                        Text("Ứng dụng trò chuyện ẩn danh",
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.sourceSansPro(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 30,
                                fontWeight: FontWeight.bold)),
                        Text(
                          "Mang đến cho bạn trải nghiệm giao tiếp hoàn tàn mới , đây là nơi bạn có thể giải tỏa các áp lực cuộc sống bằng việc chiasẻ câu chuyện của mình với những người mà bạn không hề quen biết",
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.sourceSansPro(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Container(
                height: 80,
                width: 350,
                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 59, 58, 65),
                  border: Border.all(
                    color: Colors.transparent,
                    width: 0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: TextButton(
                          
                          onPressed: () => {clickRegister()},
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft),
                          child: Container(
                            margin: EdgeInsets.zero,

                            decoration: BoxDecoration(
                              color: isRegisterCLick
                                  ? Colors.white
                                  : Color.fromARGB(255, 59, 58, 65),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Text(
                                "Đăng ký",
                                style: GoogleFonts.sourceSansPro(
                                  color: isRegisterCLick
                                      ? Color.fromARGB(255, 24, 23, 31)
                                      : Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () => {clickLogin()},
                          style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft),
                          child: Container(
                            margin: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: isLoginCLick
                                  ? Colors.white
                                  : Color.fromARGB(255, 59, 58, 65),
                              border: Border.all(
                                color: Colors.transparent,
                                width: 0,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: Center(
                              child: Text(
                                "Đăng nhập",
                                style: GoogleFonts.sourceSansPro(
                                  color: isLoginCLick
                                      ? Color.fromARGB(255, 59, 58, 65)
                                      : Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )),
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
