import 'http_manager.dart';
import 'result_data.dart';

extension HttpExtension on String {
  ///Post请求
  Future<ResponseData> post(Map<String, dynamic> params, {withLoading = false, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    String url = this;
    dynamic result = await HttpManager().post(url, params: params, isJson: isJson, hideMsg: hideMsg, isNeedCommonParams: isNeedCommonParams);
    if (result is ResponseData) {
      return result;
    }
    // if (GlobalConfig.isDebug) {
    //   throw UnsupportedError("统一返回值类型应该为ResponseData,当前类型为:${result.runtimeType},${result.toString()},需处理下");
    // }
    return ResponseData(code: "-1", data: {}, msg: "数据出现点问题");
  }

  ///Get请求
  Future<ResponseData> get(Map<String, dynamic> params, {withLoading = false, hideMsg = false}) async {
    String url = this;
    dynamic result = await HttpManager().get(url, params: params, hideMsg: hideMsg);
    if (result is ResponseData) {
      return result;
    }
    // if (GlobalConfig.isDebug) {
    //   throw UnsupportedError("统一返回值类型应该为ResponseData,当前类型为:${result.runtimeType},${result.toString()},需处理下");
    // }
    return ResponseData(code: "-1", data: {}, msg: "数据出现点问题");
  }
  ///Put请求
  Future<ResponseData> put(Map<String, dynamic> params, {withLoading = false, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    String url = this;
    dynamic result = await HttpManager().put(url, params: params, isJson: isJson, hideMsg: hideMsg, isNeedCommonParams: isNeedCommonParams);
    if (result is ResponseData) {
      return result;
    }
    // if (GlobalConfig.isDebug) {
    //   throw UnsupportedError("统一返回值类型应该为ResponseData,当前类型为:${result.runtimeType},${result.toString()},需处理下");
    // }
    return ResponseData(code: "-1", data: {}, msg: "数据出现点问题");
  }
  ///Delete请求
  Future<ResponseData> delete(Map<String, dynamic> params, {withLoading = false, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    String url = this;
    dynamic result = await HttpManager().delete(url, params: params, isJson: isJson, hideMsg: hideMsg, isNeedCommonParams: isNeedCommonParams);
    if (result is ResponseData) {
      return result;
    }
    // if (GlobalConfig.isDebug) {
    //   throw UnsupportedError("统一返回值类型应该为ResponseData,当前类型为:${result.runtimeType},${result.toString()},需处理下");
    // }
    return ResponseData(code: "-1", data: {}, msg: "数据出现点问题");
  }

  Future<dynamic> postStream(Map<String, dynamic> params, {hideMsg = false, receiveTimeout = 60000}) async {
    String url = this;
    dynamic result = await HttpManager().postStream(url, params: params, hideMsg: hideMsg, receiveTimeout: receiveTimeout);
    return result;
    if (result is ResponseData) {
      return result;
    }
    // if (GlobalConfig.isDebug) {
    //   throw UnsupportedError("统一返回值类型应该为ResponseData,当前类型为:${result.runtimeType},${result.toString()},需处理下");
    // }
    return ResponseData(code: "-1", data: {}, msg: "数据出现点问题");
  }
}
