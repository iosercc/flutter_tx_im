import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:tencent_cloud_chat_demo/network/dio_log/interceptor/dio_log_interceptor.dart';
import 'package:tencent_cloud_chat_demo/utils/toast.dart';
import 'network_utils.dart';
import 'result_data.dart';

final _setCookieReg = RegExp('(?<=)(,)(?=[^;]+?=)');

class HttpManager {
  static Dio? _dio;

  factory HttpManager() => _sharedInstance();
  static HttpManager? _instance;

  HttpManager._() {
    if (null == _dio) {
      _dio = Dio(BaseOptions(connectTimeout: const Duration(milliseconds: 15000)));
      // _dio!.interceptors.add(RequestInterceptors());
      _dio!.interceptors.add(DioLogInterceptor());
      // final cookieJar = CookieJar();
      // _dio!.interceptors.add(CookieManager(cookieJar));
    }
  }

  static HttpManager _sharedInstance() {
    _instance ??= HttpManager._();
    return _instance!;
  }

  static int getNowTempStamp() {
    return int.parse((DateTime
        .now()
        .millisecondsSinceEpoch / 1000).toStringAsFixed(0));
  }

  ///通用的GET请求
  Future<ResponseData> get(api, {required Map<String, dynamic> params, withLoading = true, hideMsg = false}) async {
    _dio!.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio!.options.contentType = "application/json";
    _dio!.options.headers['Authorization'] = NetWorkUtils.getToken();
    try {
      Response response = await _dio!.get(api, queryParameters: params);
      return httpSuccessHandle(response, hideMsg);
    } on DioError catch (e) {
      return httpErrorHandle(e, hideMsg: hideMsg);
    }
  }

  ///通用的POST请求
  Future<ResponseData> post(api, {required Map<String, dynamic> params, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    _dio!.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio!.options.sendTimeout = const Duration(milliseconds: 15000);
    _dio!.options.receiveTimeout = const Duration(milliseconds: 15000);
    _dio!.options.contentType = "application/json";
    _dio!.options.responseType = ResponseType.json;
    //公共参数
    if (isNeedCommonParams) {

    }
    _dio!.options.headers['Authorization'] = NetWorkUtils.getToken();
    try {
      Response<dynamic> response = await _dio!.post(api, data: isJson ? params : FormData.fromMap(params));
      return httpSuccessHandle(response, hideMsg);
    } on DioError catch (e) {
      return httpErrorHandle(e, hideMsg: hideMsg);
    }
  }

  ///通用的PUT请求
  Future<ResponseData> put(api, {required Map<String, dynamic> params, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    _dio!.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio!.options.sendTimeout = const Duration(milliseconds: 15000);
    _dio!.options.receiveTimeout = const Duration(milliseconds: 15000);
    _dio!.options.contentType = "application/json";
    _dio!.options.responseType = ResponseType.json;
    //公共参数
    if (isNeedCommonParams) {

    }
    _dio!.options.headers['Authorization'] = NetWorkUtils.getToken();
    try {
      Response<dynamic> response = await _dio!.put(api, data: isJson ? params : FormData.fromMap(params));
      return httpSuccessHandle(response, hideMsg);
    } on DioError catch (e) {
      return httpErrorHandle(e, hideMsg: hideMsg);
    }
  }

  ///通用的DELETE请求
  Future<ResponseData> delete(api, {required Map<String, dynamic> params, isJson = true, hideMsg = false, isNeedCommonParams = true}) async {
    _dio!.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio!.options.sendTimeout = const Duration(milliseconds: 15000);
    _dio!.options.receiveTimeout = const Duration(milliseconds: 15000);
    _dio!.options.contentType = "application/json";
    _dio!.options.responseType = ResponseType.json;
    //公共参数
    if (isNeedCommonParams) {

    }
    _dio!.options.headers['Authorization'] = NetWorkUtils.getToken();
    try {
      Response<dynamic> response = await _dio!.delete(api, data: isJson ? params : FormData.fromMap(params));
      return httpSuccessHandle(response, hideMsg);
    } on DioError catch (e) {
      return httpErrorHandle(e, hideMsg: hideMsg);
    }
  }

  postStream(api, {required Map<String, dynamic> params, bool hideMsg = false, int receiveTimeout = 60000}) async {
    _dio!.options.connectTimeout = const Duration(milliseconds: 15000);
    _dio!.options.sendTimeout = const Duration(milliseconds: 15000);
    _dio!.options.receiveTimeout = Duration(milliseconds: receiveTimeout);
    _dio!.options.contentType = "application/json";
    _dio!.options.responseType = ResponseType.stream;
    _dio!.options.headers['Authorization'] = NetWorkUtils.getToken();
    // }
    try {
      Response<ResponseBody> response =
      await _dio!.post(api, data: params, options: Options(responseType: ResponseType.stream));
      return response;
    } on DioError catch (e) {
      return httpErrorHandle(e, hideMsg: hideMsg);
    }
  }

  ///下载文件到本地
  ///urlPath 文件Url
  ///savePath 本地保存位置
  ///downloadProgressCallBack 下载文件回调
  Future<Response> downloadFile(String urlPath, String savePath, {DownloadProgressCallBack? downloadProgressCallBack}) async {
    Dio dio = Dio();
    return await dio.download(urlPath, savePath, onReceiveProgress: downloadProgressCallBack);
  }

  ///加密参数
  // encryptParams(Map<String, dynamic> params) {
  //   String paramsStr = jsonEncode(params).replaceAll(' ', '').replaceAll('\n', '').replaceAll('\r', '');
  //   String paramsUrl = Uri.encodeQueryComponent(paramsStr);
  //   paramsUrl = paramsUrl.replaceAll('%2A', '*');
  //   List<String> paramsList = [];
  //   while (paramsUrl.isNotEmpty) {
  //     if (paramsUrl.length >= 18) {
  //       paramsList.add(paramsUrl.substring(0, 18));
  //       paramsUrl = paramsUrl.substring(18);
  //     } else {
  //       paramsList.add(paramsUrl);
  //       paramsUrl = "";
  //     }
  //   }
  //   paramsList.sort();
  //   String tempStr = "";
  //   for (String str in paramsList) {
  //     tempStr += str;
  //   }
  //   tempStr += NetWorkUtils.config.signKey;
  //   var bytes = utf8.encode(tempStr);
  //   tempStr = sha256.convert(bytes).toString();
  //   var content = const Utf8Encoder().convert(tempStr);
  //   var digest = md5.convert(content);
  //   return digest.toString();
  // }
}

typedef DownloadProgressCallBack = Function(int count, int total);

///成功处理
Future<ResponseData> httpSuccessHandle(Response response, bool hideMsg) async {
  ResponseData responseData;
  if (response.headers['set-cookie'] != null) {
    final setCookies = response.headers[HttpHeaders.setCookieHeader];
    if (setCookies != null) {
      List<Cookie> cookies = setCookies
          .map((str) => str.split(_setCookieReg))
          .expand((cookie) => cookie)
          .where((cookie) => cookie.isNotEmpty)
          .map((str) => Cookie.fromSetCookieValue(str))
          .toList();
      final newCookies = getCookies(cookies);
      print('newCookies: $newCookies');
      if (newCookies.isNotEmpty) {
        await NetWorkUtils.setToken(newCookies);
      }
    }
  }
  if (response.data is String || response.data is Map) {
    String responseStr = "";

    if (response.data is Map) {
      responseStr = jsonEncode(response.data);
    } else {
      responseStr = response.data.toString();
    }
    Map<String, dynamic> mapResult = jsonDecode(responseStr);
    responseData = ResponseData.fromJson(mapResult);
  } else {
    responseData = ResponseData.fromJson(response.data);
  }
  if (!responseData.isSuccess()) {
    String errorMsg = responseData.msg ?? "";
    if (errorMsg.isNotEmpty && !hideMsg) {
      ToastUtils.toast(errorMsg);
    }
  }
  return responseData;
}

///处理错误
Future<ResponseData> httpErrorHandle(DioError e, {hideMsg = false}) async {
  String errorMsg = "";
  if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
    errorMsg = NetWorkUtils.config?.requestTimeoutTip ?? '';
  } else {
    errorMsg = NetWorkUtils.config?.requestErrorTip ?? '';
  }
  if (!hideMsg && errorMsg.isNotEmpty) {
    ToastUtils.toast(errorMsg);
  }
  return ResponseData(code: "-1", data: {}, msg: errorMsg);
}

String getCookies(List<Cookie> cookies) {
// Sort cookies by path (longer path first).
  cookies.sort((a, b) {
    if (a.path == null && b.path == null) {
      return 0;
    } else if (a.path == null) {
      return -1;
    } else if (b.path == null) {
      return 1;
    } else {
      return (b.path!.length).compareTo(a.path!.length);
    }
  });
  return cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
}
