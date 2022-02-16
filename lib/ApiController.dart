import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static final HOST = "http://117.5.237.5:8080";

  static Future<String> Register(username, password, birthday, sex) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(HOST + '/api/user/register'));
    request.body = json.encode({
      "username": username,
      "password": password,
      "email": username + "@aichat.com",
      "birthday": birthday,
      "sex": sex
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw new Exception(response.statusCode);
    }
  }



  static Future<String> Login(username, password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(HOST + '/login'));
    request.body = json.encode({"username": username, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw new Exception(response.statusCode);
    }
  }


  static Future<String> GetInfo(token) async {
    String tokens = token;
    var headers = {
      'Authorization': tokens,
    };
    var request = http.Request('GET', Uri.parse(HOST + '/api/user/info'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> SetBlock(token,blocker) async {
    var headers = {
      'Authorization': '${token!}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var request = http.Request('POST', Uri.parse(HOST+'/api/user/block'));
    request.bodyFields = {
      'blocker': '${blocker!}'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }


  }
  static Future<String> SetEvaluate(token,String username,int point) async {
    var headers = {
      'Authorization': '${token!}',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    var request = http.Request('POST', Uri.parse('localhost:8080/api/user/evaluate'));
    request.bodyFields = {
      'username': '${username!}',
      'point': '${point!}'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> ChangePassword(token,String oldPassword,String newPassword) async {
    var headers = {
      'Authorization': '${token!}',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(HOST+'/api/user/changepassword'));
    request.bodyFields = {
      'oldpassword': '${oldPassword!}',
      'newpassword': '${newPassword!}'
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> SetToken(token,tokenfb) async {
    String tokens = token;
    String tokenfb2 = tokenfb;
    var headers = {
      'Authorization': tokens,
    };
    var request = http.Request('POST', Uri.parse(HOST + '/api/user/token'));
    request.bodyFields = {
      'tokens': tokenfb2
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> SendNotificationRequest(token,username) async {
    String username1 = username;
    String token1 = token;
    var headers = {
      'Authorization': token1,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(HOST+'/api/user/notification'));
    request.bodyFields = {
      'username': username1
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> SendNotification(token,username,status) async {
    String username1 = username;
    String status1 = status;
    String token1 = token;
    var headers = {
      'Authorization': token1,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(HOST+'/api/user/notificationfeedback'));
    request.bodyFields = {
      'username': username1,
      'status':status1
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }
  static Future<String> GetInfoUser(token, username) async {
    String tokens = token;
    var headers = {
      'Authorization': tokens,
    };
    var request = http.Request('GET', Uri.parse(HOST + '/api/user/infouser?username='+username));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    }
    else {
      throw new Exception(response.statusCode);
    }

  }

  static Future<String> GetUserList(
      token, birthdaymin, birthdaymax, sex) async {
    String? token2 = token;
    var headers = {
      'Authorization': token2!,
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(HOST + '/api/message/users'));
    request.bodyFields = {
      'birthdaymin': birthdaymin.toString(),
      'birthdaymax': birthdaymax.toString(),
      'sex': sex.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      return await response.stream.bytesToString();
    } else {
      throw new Exception(response.statusCode);
    }
  }
}
