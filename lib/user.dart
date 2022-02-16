class User {
  Data? data;
  int? id;
  String? createAt;
  String? token;

  User({this.data, this.id, this.createAt, this.token});

  User.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    id = json['id'];
    createAt = json['create_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['id'] = this.id;
    data['create_at'] = this.createAt;
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? username;
  String? password;
  String? email;
  UserInfo? userInfo;
  List<Roles>? roles;

  Data(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.username,
      this.password,
      this.email,
      this.userInfo,
      this.roles});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email'] = this.email;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserInfo {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? sex;
  double? quantityMessageUser;
  double? quatityUserRequest;
  List<Evaluates>? evaluates;
  List<ListBlocker>? listBlocker;
  int? dateOfBirth;

  UserInfo(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.sex,
      this.quantityMessageUser,
      this.quatityUserRequest,
      this.evaluates,
      this.listBlocker,
      this.dateOfBirth});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    sex = json['sex'];
    quantityMessageUser = json['quantityMessageUser'];
    quatityUserRequest = json['quatityUserRequest'];
    if (json['evaluates'] != null) {
      evaluates = <Evaluates>[];
      json['evaluates'].forEach((v) {
        evaluates!.add(new Evaluates.fromJson(v));
      });
    }
    if (json['listBlocker'] != null) {
      listBlocker = <ListBlocker>[];
      json['listBlocker'].forEach((v) {
        listBlocker!.add(new ListBlocker.fromJson(v));
      });
    }
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['sex'] = this.sex;
    data['quantityMessageUser'] = this.quantityMessageUser;
    data['quatityUserRequest'] = this.quatityUserRequest;
    if (this.evaluates != null) {
      data['evaluates'] = this.evaluates!.map((v) => v.toJson()).toList();
    }
    if (this.listBlocker != null) {
      data['listBlocker'] = this.listBlocker!.map((v) => v.toJson()).toList();
    }
    data['dateOfBirth'] = this.dateOfBirth;
    return data;
  }
}

class Evaluates {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? idUserEvaluate;
  double? point;

  Evaluates(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.idUserEvaluate,
      this.point});

  Evaluates.fromJson(Map<String, dynamic> json) {
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

class ListBlocker {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  int? idUserBlock;
  String? name;

  ListBlocker(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.idUserBlock,
      this.name});

  ListBlocker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    idUserBlock = json['idUserBlock'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['idUserBlock'] = this.idUserBlock;
    data['name'] = this.name;
    return data;
  }
}

class Roles {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? key;
  String? name;
  List<Permissions>? permissions;

  Roles(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.key,
      this.name,
      this.permissions});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    key = json['key'];
    name = json['name'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(new Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['key'] = this.key;
    data['name'] = this.name;
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Permissions {
  int? id;
  bool? deleted;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? key;
  String? name;

  Permissions(
      {this.id,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.key,
      this.name});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deleted = json['deleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deleted'] = this.deleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}
