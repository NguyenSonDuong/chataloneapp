import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:http/http.dart';

import 'message.dart';

class SearchStateful extends StatefulWidget {
  User data;

  SearchStateful( this.data);

  @override
  SearchScreen createState() => SearchScreen(data);
}

class SearchScreen extends State<SearchStateful> {
  User user;

  SearchScreen( this.user);



  List<UserSearch> listUser = [];




  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                "images/headerimage2.png",
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(40.0, 280.0, 40, 0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Tìm kiếm",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: new Color.fromARGB(255, 254, 141, 40)),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: ListView.builder(
                              reverse: false,
                              itemCount: listUser.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: UserInfoItem(listUser[index]),
                                  ),
                                  onTap: () async {
                                    // socket.add(utf8.encode(json.encode(listUser[index].toJson(UserSearch.fromJson(json.decode(data)).id))));

                                    // Navigator.push(
                                    //     context,
                                    //     new MaterialPageRoute(
                                    //         builder: (context) => MyHomePage(user,listUser[index]),
                                    //     )
                                    // );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserSearch {
  int id;
  String name;
  String sex;
  int birthday;
  double point;
  String avatar = "";

  UserSearch(
      this.id, this.name, this.sex, this.birthday, this.point, this.avatar);

  Map<String, dynamic> toJson(int idSend) => {
        "id": id,
        "idSend": idSend,
        "name": name,
        "sex": sex,
        "birthday": birthday,
        "point": point,
        "avatar": "a",
      };

  UserSearch.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['username'].toString().trim(),
        sex = "none",
        birthday = json['birthday'],
        point = double.parse(json['point'].toString()),
        avatar = "";
}

class UserInfoItem extends StatelessWidget {
  UserSearch userSearch;

  UserInfoItem(this.userSearch);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromARGB(255, 254, 141, 40)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Image.asset(
              "images/profile.png",
              height: 50,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userSearch.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(
                              "Giới tính: ",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(userSearch.sex,
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text("Năm sinh: ",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(userSearch.birthday.toString(),
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white)),
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
              child: Text(
                userSearch.point.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
