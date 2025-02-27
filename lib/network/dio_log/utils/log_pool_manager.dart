import 'dart:collection';
import 'package:tencent_cloud_chat_demo/network/network_utils.dart';
import '../bean/err_options.dart';
import '../bean/net_options.dart';
import '../bean/req_options.dart';
import '../bean/res_options.dart';

///log管理
class LogPoolManager {
  ///请求日志存储
  late LinkedHashMap<String, NetOptions> logMap;

  late List<String> keys;

  ///存储请求最大数
  int maxCount = 50;

  ResError isError = (res) => res.errOptions != null || res.resOptions?.statusCode == null;

  ResError isServiceError = (res) {
    if (res.resOptions?.statusCode != null && res.resOptions?.data is Map) {
      if (res.resOptions!.data['errCode'] != NetWorkUtils.config.successCode) {
        return true;
      }
    }
    return false;
  };

  static LogPoolManager? _instance;

  LogPoolManager._singleton() {
    logMap = LinkedHashMap();
    keys = <String>[];
  }

  static LogPoolManager getInstance() {
    if (_instance == null) {
      _instance = LogPoolManager._singleton();
    }
    return _instance!;
  }

  void onError(ErrOptions err) {
    var key = err.id.toString();
    if (logMap.containsKey(key)) {
      logMap.update(key, (value) {
        value.errOptions = err;
        return value;
      });
    }
  }

  void onRequest(ReqOptions options) {
    if (logMap.length >= maxCount) {
      logMap.remove(keys.last);
      keys.removeLast();
    }
    var key = options.id.toString();
    keys.insert(0, key);
    logMap.putIfAbsent(key, () => NetOptions(reqOptions: options));
  }

  void onResponse(ResOptions response) {
    var key = response.id.toString();
    if (logMap.containsKey(key)) {
      logMap.update(key, (value) {
        response.duration = response.responseTime!.millisecondsSinceEpoch - value.reqOptions!.requestTime!.millisecondsSinceEpoch;
        value.resOptions = response;
        return value;
      });
    }
  }

  ///日志清除
  void clear() {
    logMap.clear();
    keys.clear();
  }
}
