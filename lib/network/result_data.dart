import 'network_utils.dart';

class ResponseData {
  String? code;
  dynamic data;
  String? msg;
  int? time;
  String? errCode;

  ResponseData({this.code, this.msg, this.data,this.time,this.errCode});

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    msg = json['msg'];
    data = json['data'];
    time = json['time'];
    errCode = json['errCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['data'] = data;
    data['time'] = time;
    data['errCode'] = errCode;
    return data;
  }

  bool isSuccess() {
    return code == NetWorkUtils.config.successCode;
  }
}
