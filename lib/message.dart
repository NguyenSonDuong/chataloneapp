import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socket/setting.dart';
import 'package:flutter_socket/user.dart';
import 'package:flutter_socket/userlist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:intl/intl.dart';

import 'ApiController.dart';
import 'UserInfoList.dart';
import 'menu.dart';

class MyHomePage extends StatefulWidget {
  User user;
  UserListInfor userTo;

  MyHomePage(this.user, this.userTo);

  @override
  _MyHomePageState createState() => _MyHomePageState(user, userTo);
}

final socketUrl = 'http://117.5.237.5:8080/ws';

class _MyHomePageState extends State<MyHomePage> {
  User user;
  UserListInfor userTo;
  String keyMess = "";
  _MyHomePageState(this.user, this.userTo);

  List<MessageModel> listMess = [];
  StompClient? stompClient;
  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
        destination: '/topicchat/topic/message.user-' + user.data!.username!,
        callback: (StompFrame frame) {
          if (frame.body != null) {
            Map<String, dynamic> result = json.decode(frame.body!);
            result["isMe"] = false;
            //print(result['message']);
            MessageModel messageModel = MessageModel.fromJson(result);
            messageModel.isMe = false;
            setState(() => listMess.add(messageModel));
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent + 50);
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (stompClient == null) {
      stompClient = StompClient(
          config: StompConfig.SockJS(
            url: socketUrl,
            onConnect: onConnect,
            onWebSocketError: (dynamic error) => print(error.toString()),
            stompConnectHeaders: {
              'Authorization':
              user.token!
            },
            webSocketConnectHeaders: {
              'Authorization':
              user.token!
            },
          ));

      stompClient!.activate();
    }
  }

  void _incrementCounter(String message, String type, bool isMe) {
    String nowDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    MessageModel messageModel = MessageModel(
        '$message', "", userTo.username!, nowDate, "chat", 'text', isMe);
    String body = jsonEncode(messageModel.toJson());
    setState(() {
      listMess.add(messageModel);
    });
    stompClient!
        .send(destination: '/appchat/sendMessage', body: body, headers: {});
  }

  var _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  void onSendIconPressed() {
    _incrementCounter(_controller.text, 'text', true);
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 50);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 23, 31),
        appBar: AppBar(
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 24, 23, 31),
          title: AppBarHeader(userTo.username!, "3",user,userTo),
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView.builder(
                    controller: _scrollController,
                    reverse: false,
                    itemCount: listMess.length,
                    padding: const EdgeInsets.all(5),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(5),
                        child: MessageItem(listMess[index]),
                      );
                    },
                  ),
                )),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 59, 58, 65),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextFormField(
                                controller: _controller,
                                style: GoogleFonts.sourceSansPro(
                                    color: Colors.white, fontSize: 15),
                                decoration: InputDecoration(
                                    hintStyle: GoogleFonts.sourceSansPro(
                                        color: Colors.grey, fontSize: 15),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                        left: 20, bottom: 0, top: 0, right: 20),
                                    hintText: "Tin nhắn"),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            padding: const EdgeInsets.all(0.0),
                            child: TextButton(
                              onPressed: () => {onSendIconPressed()},
                              child: Icon(Icons.send,
                                  size: 35, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageModel {
  String? content;
  String? data;
  String? sender;
  String? create_time;
  String? messageStatus;
  String? messageType;
  bool isMe = true;
  MessageModel(this.content, this.data, this.sender, this.create_time,
      this.messageStatus, this.messageType, this.isMe);

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    data = json['data'];
    sender = json['sender'];
    create_time = json['create_time'];
    messageStatus = json['messageStatus'];
    messageType = json['messageType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['data'] = this.data;
    data['sender'] = this.sender;
    data['create_time'] = this.create_time;
    data['messageStatus'] = this.messageStatus;
    data['messageType'] = this.messageType;
    return data;
  }
}

class MessageItem extends StatelessWidget {
  MessageModel message;

  MessageItem(this.message);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment:
      message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color:
              message.isMe ? Colors.white : Color.fromARGB(255, 59, 58, 65),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(15),
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.content!,
                    style: TextStyle(
                        color: message.isMe ? Colors.black : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppBarHeader extends StatelessWidget {
  String name = "Chat AI";
  String timeActive = "10";

  User user;
  UserListInfor userTo;


  AppBarHeader(this.name, this.timeActive, this.user, this.userTo);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: TextButton(
                onPressed: ()  async {
                  try{
                    await API.SendNotification(user.token,name,"CLOSE");
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => MenuStateful(user),
                        ), (r)=>false);
                  }catch(e){
                    print(e);
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$name',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => SettingReportStateful(user,userTo),
                      ));
                },
                child: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}