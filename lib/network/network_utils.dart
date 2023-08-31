import 'package:sp_util/sp_util.dart';

import 'network_config.dart';

class NetWorkUtils {
  //单例
  factory NetWorkUtils() => _getInstance();

  static NetWorkUtils get instance => _getInstance();
  static NetWorkUtils? _instance;
  static late NetWorkConfig config;
  static bool isShowUpdateDialog = false;
  NetWorkUtils._internal();

  static NetWorkUtils _getInstance() {
    _instance ??= NetWorkUtils._internal();
    return _instance!;
  }

  initConfig(NetWorkConfig config) {
    NetWorkUtils.config = config;
  }

  static Future<bool> setToken(String cookie) async {
    return await SpUtil.putString('token', cookie) ?? false;
  }
  static String getToken() {
    String token = SpUtil.getString('token', defValue: "") ?? "";
    return token;
  }
}