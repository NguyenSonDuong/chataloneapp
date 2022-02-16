import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_socket/menu.dart';
import 'package:flutter_socket/privatechat.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

import 'ApiController.dart';
import 'UserInfoList.dart';
import 'message.dart';

class UserlistStateful extends StatefulWidget {

  User user;

  var birthdayMin;
  var birthdatMax;
  var sex;


  UserlistStateful(this.user, this.birthdayMin,this.birthdatMax,this.sex);

  @override
  UserlistScreen createState() => UserlistScreen(this.user, this.birthdayMin,this.birthdatMax,this.sex);
}

class UserlistScreen extends State<UserlistStateful> {
  late List<UserListInfor> list = [];

  User user;
  var birthdayMin;
  var birthdatMax;
  var sex = -1;

  var listtTypeSex = ["Nam","Nữ","Khác"];
  var selectValue = "Nam";
  List<int> listtDOB = [];
  var selectMin = 1990;
  var selectMax = 2010;

  UserlistScreen(this.user, this.birthdayMin, this.birthdatMax, this.sex);

  void ActionGetUser(data){

    list.clear();
    var objData = jsonDecode(data);
    setState(() {
      for(var obj in objData){
        list.add(UserListInfor.fromJson(obj));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 1900 ;i<= 2010;i++)
      listtDOB.add(i);
    setState(() {
      selectValue = sex > 0 ? "Nam" : (sex == 0 ? "Nữ" : "Khác");
    });
    GetList();

  }
  void GetList() {
    API.GetUserList(this.user.token,birthdayMin,birthdatMax,sex )
        .then(ActionGetUser)
        .onError((error, stackTrace) => {});
  }
  void GetListSort(token , birthday1, birthdat2,sex1) {
    API.GetUserList(token,birthday1,birthdat2,sex1 == "Nam" ? 1 : (sex1 == "Khác" ? -1 : 0) )
        .then(ActionGetUser)
        .onError((error, stackTrace) => {
    });
  }

  TextEditingController txtDOBStart = TextEditingController();
  TextEditingController txtDOBEnd = TextEditingController();

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
                              "Danh sách người dùng",
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
                              "Danh sách những người dùng phù hợp với bạn",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.sourceSansPro(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 58, 65),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<String>(
                                    value: selectValue,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    underline: SizedBox(),
                                    elevation: 3,
                                    dropdownColor: Color.fromARGB(255, 59, 58, 65),
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (String? sex){
                                      setState(() => selectValue = sex!);
                                      GetListSort(this.user.token, selectMin, selectMax, selectValue);
                                    },
                                    items: listtTypeSex.map<DropdownMenuItem<String>>((String e)  {
                                      return DropdownMenuItem<String>(value: e ,
                                          child: Text(
                                            e,style: GoogleFonts.sourceSansPro(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),) );

                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 58, 65),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<int>(
                                    value: selectMin,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    underline: SizedBox(),
                                    elevation: 3,
                                    dropdownColor: Color.fromARGB(255, 59, 58, 65),
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (int? min){
                                      setState(() => selectMin = min!);
                                      GetListSort(this.user.token, min, selectMax, selectValue);
                                    },
                                    items: listtDOB.map<DropdownMenuItem<int>>((int e)  {
                                      return DropdownMenuItem<int>(
                                          value: e,
                                          child: Text(
                                            '${e}',
                                            style: GoogleFonts.sourceSansPro(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                      );

                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 59, 58, 65),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: DropdownButton<int>(
                                    value: selectMax,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    underline: SizedBox(),
                                    elevation: 3,
                                    dropdownColor: Color.fromARGB(255, 59, 58, 65),
                                    style: GoogleFonts.sourceSansPro(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    onChanged: (int? max){
                                      setState(() => selectMax = max!);
                                      GetListSort(this.user.token, selectMin, max, selectValue);
                                    },
                                    items: listtDOB.map<DropdownMenuItem<int>>((int e)  {
                                      return DropdownMenuItem<int>(
                                          value: e,
                                          child: Text(
                                            '${e}',
                                            style: GoogleFonts.sourceSansPro(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                      );

                                    }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: ListView.builder(
                                reverse: false,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      child: UserInfoItem(list[index]),
                                    ),
                                    onTap: () async {
                                      await API.SendNotificationRequest(user.token,list[index].username);
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (context) => MyHomePage(user,list[index]),
                                          ));
                                    },
                                  );
                                },
                              ),
                            ),
                          )
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

class UserInfoItem extends StatelessWidget {
  UserListInfor userSearch;

  UserInfoItem(this.userSearch);

  @override
  Widget build(BuildContext context) {
    String? username = userSearch.username;
    int? sex = userSearch.sex;
    int? dateofbirth = userSearch.birthday;
    double? point = userSearch.point;

    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 59, 58, 65)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      username!,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Giới tính: ",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text((sex == 0 ? "Nữ" : "Nam"),
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text("Năm sinh: ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text("${dateofbirth!}",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Text(
                      point!.toStringAsFixed(2),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}