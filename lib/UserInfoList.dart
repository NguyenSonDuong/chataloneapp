class UserListInfor {
  int? birthday;
  int? sex;
  String? email;
  String? username;
  double? point;
  String? status;

  UserListInfor(
      {this.birthday, this.sex, this.email, this.username,this.point, this.status});

  UserListInfor.fromJson(Map<String, dynamic> json) {
    birthday = json['birthday'];
    sex = json['sex'];
    email = json['email'];
    username = json['username'];
    point = json['point'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['birthday'] = this.birthday;
    data['sex'] = this.sex;
    data['email'] = this.email;
    data['username'] = this.username;
    data['point'] = this.point;
    data['status'] = this.status;
    return data;
  }
}