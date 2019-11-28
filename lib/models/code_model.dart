
///
/// @name CodeModel
/// @description 验证码model添加
/// @author lca
/// @date 2019-11-28
///
class CodeModel {
  int code;
  String message;

  CodeModel({this.code, this.message});

  CodeModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}