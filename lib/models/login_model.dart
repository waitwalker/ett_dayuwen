
///
/// @name LoginModel
/// @description 登录model
/// @author lca
/// @date 2019-11-26
///
class LoginModel {
  int code;
  UserInfo userInfo;
  String token;
  String message;
  int userType;

  LoginModel({this.code, this.userInfo, this.token, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

class UserInfo {
  String phone;
  String areaCode;
  String name;
  String grade;
  String genre;
  bool isAuth;
  int role;
  int score;
  String createdAt;
  String updatedAt;
  String objectId;

  UserInfo(
      {this.phone,
        this.areaCode,
        this.name,
        this.grade,
        this.genre,
        this.isAuth,
        this.role,
        this.score,
        this.createdAt,
        this.updatedAt,
        this.objectId});

  UserInfo.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    areaCode = json['areaCode'];
    name = json['name'];
    grade = json['grade'];
    genre = json['genre'];
    isAuth = json['isAuth'];
    role = json['role'];
    score = json['score'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    objectId = json['objectId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['areaCode'] = this.areaCode;
    data['name'] = this.name;
    data['grade'] = this.grade;
    data['genre'] = this.genre;
    data['isAuth'] = this.isAuth;
    data['role'] = this.role;
    data['score'] = this.score;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['objectId'] = this.objectId;
    return data;
  }
}