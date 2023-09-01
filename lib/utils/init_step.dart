import 'package:flutter/cupertino.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tencent_cloud_chat_demo/model/global_config.dart';
import 'package:tencent_cloud_chat_demo/model/user_model.dart';
import 'package:tencent_cloud_chat_demo/network/api.dart';
import 'package:tencent_cloud_chat_demo/network/http_extension.dart';
import 'package:tencent_cloud_chat_demo/network/network.dart';
import 'package:tencent_cloud_chat_demo/network/network_config.dart';
import 'package:tencent_cloud_chat_demo/network/network_utils.dart';
import 'package:tencent_cloud_chat_demo/src/config.dart';
import 'package:tencent_cloud_chat_demo/src/pages/cross_platform/wide_screen/home_page.dart';
import 'package:tencent_cloud_chat_demo/src/pages/home_page.dart';
import 'package:tencent_cloud_chat_demo/src/pages/login.dart';
import 'package:tencent_cloud_chat_demo/src/provider/custom_sticker_package.dart';
import 'package:tencent_cloud_chat_demo/src/provider/theme.dart';
import 'package:tencent_cloud_chat_demo/utils/GenerateUserSig.dart';
import 'package:tencent_cloud_chat_demo/utils/constant.dart';
import 'package:tencent_cloud_chat_demo/utils/im_service_manager.dart';
import 'package:tencent_cloud_chat_demo/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:tencent_cloud_chat_demo/utils/toast.dart';
import 'package:tencent_cloud_chat_demo/utils/user_utils.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:tencent_cloud_chat_uikit/ui/utils/screen_utils.dart';

class InitStep {
  static setTheme(String themeTypeString, BuildContext context) {
    final CoreServicesImpl _coreInstance = TIMUIKitCore.getInstance();
    ThemeType themeType = DefTheme.themeTypeFromString(themeTypeString);
    Provider.of<DefaultThemeData>(context, listen: false).currentThemeType =
        themeType;
    Provider.of<DefaultThemeData>(context, listen: false).theme =
        DefTheme.defaultTheme[themeType]!;
    _coreInstance.setTheme(theme: DefTheme.defaultTheme[themeType]!);
  }

  static setCustomSticker(BuildContext context) async {
    if (NetWorkUtils.getToken().isEmpty) return;
    ResponseData responseData = await Api.myEmojiList.get({});
    if (responseData.isSuccess()) {
      List emojiList = responseData.data;
      List<CustomSticker> modelList = emojiList
          .map((e) => CustomSticker.fromJson(e, emojiList.indexOf(e)))
          .toList();
      GlobalConfig.emojiList = modelList;
    }
  }

  static void removeLocalSetting() async {}

  static directToLogin(BuildContext context,
      [Function? initIMSDKAndAddIMListeners]) {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: LoginPage(initIMSDK: initIMSDKAndAddIMListeners),
          );
        },
      ),
      ModalRoute.withName('/'),
    );
  }

  static directToHomePage(BuildContext context) {
    final isWideScreen =
        TUIKitScreenUtils.getFormFactor(context) == DeviceType.Desktop;
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child:
                  isWideScreen ? const HomePageWideScreen() : const HomePage(),
            );
          },
          settings: const RouteSettings(name: '/homePage')),
      ModalRoute.withName('/'),
    );
  }

  static void checkLogin(
      BuildContext context, initIMSDKAndAddIMListeners) async {
    await SpUtil.getInstance();
    NetWorkUtils.instance
        .initConfig(NetWorkConfig(successCode: '0', noLoginCode: '401'));
    // 初始化IM SDK
    initIMSDKAndAddIMListeners();
    Future.delayed(const Duration(seconds: 2), () {
      // 判断是否登录
      if (NetWorkUtils.getToken() == null || NetWorkUtils.getToken() == '') {
        directToLogin(context, initIMSDKAndAddIMListeners);
      } else {
        IMServiceManager.loginIM(UserUtils.getUserModel()!);
        directToHomePage(context);
      }
      // directToLogin(context);
      // 修改自定义表情的执行时机
      setCustomSticker(context);
    });
  }
}
