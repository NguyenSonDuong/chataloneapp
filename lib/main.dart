import 'dart:collection';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_socket/ApiController.dart';
import 'package:flutter_socket/login.dart';
import 'package:flutter_socket/menu.dart';
import 'package:flutter_socket/register.dart';
import 'package:flutter_socket/user.dart';
import 'package:flutter_socket/userlist.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UserInfoList.dart';
import 'WecomePage.dart';
import 'message.dart';

late AndroidNotificationChannel channel;
/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late SharedPreferences prefs ;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  print(message.notification!.title);
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null ) {
    if(prefs.containsKey("username") && prefs.containsKey("token") && prefs.getString("username") != null && prefs.getString("username")!.isNotEmpty){
      String username =  prefs.getString("username")!;
      print(username);
      if(notification.title!.startsWith('[${username}]')){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title!.replaceAll('[${username}]', '').toString(),
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              "com.example.flutter_socket",
              "Chat Alone",

            ),
          ),payload: message.notification!.title! +"|"+message.notification!.body!

        );
      }

    }
    
  }
  print("Handling a background message: ${message.notification?.body}");
}
Future<void> _showMyDialog(String username,String token,context,String? title,String? content) async {
  
  RegExp regExp = new RegExp(
    "\\[(.+?)\\]",caseSensitive: false,
    multiLine: false,
  );
  String usernameTo = regExp.firstMatch(content!)!.group(1).toString();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${title!}'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${content}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Chấp nhận'),
            onPressed: () async {
              try{
                String dataJson = await API.GetInfo(token);
                Map<String, dynamic> data = jsonDecode(dataJson);
                var user = User.fromJson(data);
                user.token = token;
                dataJson = await API.GetInfoUser(token,usernameTo);
                data = jsonDecode(dataJson);
                UserListInfor userTo = UserListInfor.fromJson(data);
                await API.SendNotification(token,userTo.username,"OK");
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => MyHomePage(user,userTo)),
                    );
              }catch(e){
                print(e);
              }
            },
          ),
          TextButton(
            child: const Text('Từ chối'),
            onPressed: ()  async {
              try{
                String dataJson = await API.GetInfo(token);
                Map<String, dynamic> data = jsonDecode(dataJson);
                var user = User.fromJson(data);
                dataJson = await API.GetInfoUser(token,usernameTo);
                data = jsonDecode(dataJson);
                UserListInfor userTo = UserListInfor.fromJson(data);
                await API.SendNotification(token,userTo.username,"NO");
                Navigator.of(context).pop();
              }catch(e){
                print(e);
              }

            },
          ),
        ],
      );
    },
  );
}

Future<void> _showMyDialogAccess(String username,String token,context,String? title,String? content) async {
  //
  // RegExp regExp = new RegExp(
  //   "\\[(.+?)\\]",caseSensitive: false,
  //   multiLine: false,
  // );
  // String usernameTo = regExp.firstMatch(title!)!.group(1).toString();
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${title}'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('${content}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Đã hiểu'),
            onPressed: () async {
              try{
                String dataJson = await API.GetInfo(token);
                Map<String, dynamic> data = jsonDecode(dataJson);
                var user = User.fromJson(data);
                user.token = token;
                Navigator.pushAndRemoveUntil(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => MenuStateful(user)),
                    (r)=>false);
              }catch(e){
                print(e);
              }
            },
          ),
        ],
      );
    },
  );
}





void main() async {
  final navigatorKey = GlobalKey<NavigatorState>();
  await WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AAAAt2HkxKg:APA91bF_ROtkqBC-DvcDOz35U4bGviCfw2vGnDr1BhYrjVYLlTUYnSr3WHYLJY9SuOH41kFkx9jrTNSdttjY7feWV3beowprq-0Wr9JIPEL0xdmjt8W98AUbtgqPGJFlOnhORdK_FnpX',
      appId: '1:787621397672:android:776df66e7609f680edae9d',
      messagingSenderId: '787621397672',
      projectId: 'chatalone-10754',
    ),name: "chatalone"

  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
  );


  FirebaseMessaging messaging =  FirebaseMessaging.instance;
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if(prefs.containsKey("username") && prefs.containsKey("token") && prefs.getString("username") != null && prefs.getString("username")!.isNotEmpty){
      String username =  prefs.getString("username")!;
      String token = prefs.getString("token")!;
      if(event.notification!.title!.startsWith('[${username}]')){
        // if(event.notification!.body! == "OK"){
        //   return;
        // }
        // if(event.notification!.body! == "NO"){
        //   _showMyDialogAccess(username,token,navigatorKey.currentContext,"Từ chối tham gia","Người dùng từ chối tham gia cuộc trò chuyện");
        //   return;
        // }
        // if(event.notification!.body! == "CLOSE"){
        //   _showMyDialogAccess(username,token,navigatorKey.currentContext,"Ngắt kết nối","Người dùng đã ngắt kết nối với bạn");
        //   return;
        // }
        _showMyDialog(username,token,navigatorKey.currentContext,event.notification!.title!.toString(),event.notification?.body);
        print(event.notification?.body.toString());
      }
    }
  });
  messaging.getInitialMessage();
  String? tokenfb = await messaging.getToken();
  prefs.setString("tokenfb", tokenfb!);
  FirebaseMessaging.onMessage.handleError((error) {
    print("Erorrrrrr : ${error.toString()}");
  }).listen((event) {
    print(event.notification!.title);
    if(prefs.containsKey("username") && prefs.containsKey("token") && prefs.getString("username") != null && prefs.getString("username")!.isNotEmpty){
      String username =  prefs.getString("username")!;
      String token = prefs.getString("token")!;
      if(event.notification!.title!.startsWith('[${username}]')){
        if(event.notification!.body! == "OK"){
          return;
        }
        if(event.notification!.body! == "NO"){
          _showMyDialogAccess(username,token,navigatorKey.currentContext,"Từ chối tham gia","Người dùng từ chối tham gia cuộc trò chuyện");
          return;
        }
        if(event.notification!.body! == "CLOSE"){
          _showMyDialogAccess(username,token,navigatorKey.currentContext,"Ngắt kết nối","Người dùng đã ngắt kết nối với bạn");
          return;
        }
        _showMyDialog(username,token,navigatorKey.currentContext,event.notification!.title!.toString(),event.notification?.body);
        print(event.notification?.body.toString());
      }

    }

  });

  if(prefs.containsKey("username") && prefs.containsKey("token") && prefs.getString("username") != null && prefs.getString("username")!.isNotEmpty){
    String username =  prefs.getString("username")!;
    String token = prefs.getString("token")!;
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: null,
        macOS: null);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails().then((value) => {print(value)});
    // String username =  prefs.getString("username")!;
    // String token = prefs.getString("token")!;
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: (payload){
      var lits = payload!.split('|');
      print(payload);
      String title  = lits.elementAt (0);
      String content  = lits.elementAt (1);
      _showMyDialog(username,token,navigatorKey.currentContext,title,content);
    });
    String dataJson = await API.GetInfo(token);
    Map<String, dynamic> data = jsonDecode(dataJson);
    var user = User.fromJson(data);
    user.token = token;
    await API.SetToken(token,tokenfb);
    runApp( MaterialApp(
      home: MenuStateful(user),
      navigatorKey: navigatorKey, // Setting a global key for navigator
    ));
  }else{
    runApp( MaterialApp(
      home: MainPage(),
      navigatorKey: navigatorKey, // Setting a global key for navigator
    ));
  }

}

class MainPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MainPage> {



  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
       print(message);
      }
    });

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null ) {
    //     flutterLocalNotificationsPlugin.show(
    //       notification.hashCode,
    //       notification.title,
    //       notification.body,
    //       NotificationDetails(
    //         android: AndroidNotificationDetails(
    //           "com.example.flutter_socket",
    //           "flutter_socket",
    //         ),
    //       ),
    //     );
    //   }
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: WecomeStateful()
      home: WecomeStateful()
    );
  }
}

