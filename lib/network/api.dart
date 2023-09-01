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

  ///添加表情
  static final addEmoji = '$baseUrl/api/addEmoji';
  ///删除表情
  static final deleteEmoji = '$baseUrl/api/delEmoji';
  ///我的表情列表
  static final myEmojiList = '$baseUrl/api/emojiList';

  ///我的收藏列表
  static final collectionList = '$baseUrl/api/collectionList';
  ///添加收藏
  static final addCollection = '$baseUrl/api/addCollection';
  ///删除收藏
  static final deleteCollection = '$baseUrl/api/delCollection';
}
