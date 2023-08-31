class UserModel {
  int? id;
  String? phone;
  String? nickname;
  String? avatar;
  String? token;
  UserModel({this.id, this.phone, this.nickname, this.avatar, this.token});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['nickname'] = nickname;
    data['avatar'] = avatar;
    data['token'] = token;
    return data;
  }
}