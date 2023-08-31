import 'package:dio/dio.dart';
import 'package:tencent_cloud_chat_demo/network/network_utils.dart';
import 'package:tencent_cloud_chat_demo/utils/log_util.dart';
import '../bean/err_options.dart';
import '../bean/net_options.dart';
import '../bean/req_options.dart';
import '../bean/res_options.dart';
import '../dio_log.dart';
import 'dart:convert' as convert;

///log日志的处理类
class DioLogInterceptor implements Interceptor {
  LogPoolManager? logManage;

  ///是否打印日志到控制台
  static bool enablePrintLog = true;

  DioLogInterceptor() {
    logManage = LogPoolManager.getInstance();
  }

  ///错误数据采集
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    var errOptions = ErrOptions();
    errOptions.id = err.requestOptions.hashCode;
    errOptions.errorMsg = err.toString();
    //onResponse(err.response);
    logManage?.onError(errOptions);
    if (err.response != null) saveResponse(err.response!);
    logger.e('dio_log: request: url: ${err.toString()}');
    return handler.next(err);
  }

  ///请求体数据采集
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var reqOpt = ReqOptions();
    reqOpt.id = options.hashCode;
    reqOpt.url = options.uri.toString();
    reqOpt.method = options.method;
    reqOpt.contentType = options.contentType.toString();
    reqOpt.requestTime = DateTime.now();
    reqOpt.params = options.queryParameters;
    reqOpt.data = options.data;
    reqOpt.headers = options.headers;
    logManage?.onRequest(reqOpt);
    logger.i('开始请求：${options.uri.toString()}');
    return handler.next(options);
  }

  ///响应体数据采集
  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    saveResponse(response);
    return handler.next(response);
  }

  void saveResponse(Response response) {
    var resOpt = ResOptions();
    resOpt.id = response.requestOptions.hashCode;
    resOpt.responseTime = DateTime.now();
    resOpt.statusCode = response.statusCode ?? 0;
    resOpt.data = response.data;
    resOpt.headers = response.headers.map;
    logManage?.onResponse(resOpt);
    if (response.data is Map ) {
      if (response.data['code'].toString() != NetWorkUtils.config.successCode) {
        NetOptions log = LogPoolManager
            .getInstance()
            .logMap[resOpt.id.toString()]!;
        logger.w('dio_log: request: url: ${log.reqOptions?.url}\n'
            'dio_log: request: duration:${resOpt.duration}\n'
            'dio_log: request: method:${log.reqOptions?.method}\n'
            'dio_log: request: headers:${log.reqOptions?.headers}\n'
            'dio_log: request: params:${log.reqOptions?.data}\n'
            'dio_log: response: ${toJson(log.resOptions?.data)}\n');
      } else {
        if (enablePrintLog) {
          NetOptions log = LogPoolManager
              .getInstance()
              .logMap[resOpt.id.toString()]!;
          print('dio_log: request: url:${log.reqOptions?.url}');
          print('dio_log: request: method:${log.reqOptions?.method}');
          print('dio_log: request: headers:${log.reqOptions?.headers}');
          print('dio_log: request: params:${log.reqOptions?.data}');
          print('dio_log: request: duration:${resOpt.duration}');
          print('dio_log: response: ${toJson(log.resOptions?.data)}');
        }
      }
    }else{
      NetOptions log = LogPoolManager
          .getInstance()
          .logMap[resOpt.id.toString()]!;
      print('dio_log: request: url:${log.reqOptions?.url}');
      print('dio_log: request: method:${log.reqOptions?.method}');
      print('dio_log: request: headers:${log.reqOptions?.headers}');
      print('dio_log: request: params:${log.reqOptions?.data}');
      print('dio_log: request: duration:${resOpt.duration}');
    }
  }
}
