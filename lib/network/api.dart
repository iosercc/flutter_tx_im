class Api {
  static String baseUrl = 'http://124.220.59.166';

  /// 登录
  static final login = '$baseUrl/api/login';
  ///发送验证码
  static final sendCode = '$baseUrl/api/sendCode';
  ///获取个人信息
  static final getUserInfo = '$baseUrl/api/profile';
  ///上传图片
  static final uploadImage = '$baseUrl/api/upload';
}
