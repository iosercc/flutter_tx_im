class NetWorkConfig {
  final String successCode;
  final String noLoginCode;
  final String? requestErrorTip;
  final String? requestTimeoutTip;
  NetWorkConfig({
    this.successCode = '200',
    this.noLoginCode = '401',
    this.requestErrorTip = '网络请求失败',
    this.requestTimeoutTip = '网络请求超时',
  });
}
