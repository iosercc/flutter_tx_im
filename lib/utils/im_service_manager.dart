import 'dart:convert';
import 'dart:io';
import 'dart:math';

// import 'package:tencent_chat_push_for_china/tencent_chat_push_for_china.dart';
import 'package:tencent_cloud_chat_demo/model/user_model.dart';
import 'package:tencent_cloud_chat_demo/src/config.dart';
import 'package:tencent_cloud_chat_demo/src/provider/login_user_Info.dart';
import 'package:tencent_cloud_chat_demo/utils/toast.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimConversationListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimFriendshipListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimGroupListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSDKListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/V2TimSignalingListener.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_application_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_response_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/friend_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_add_opt_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_application_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_member_filter_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_member_filter_type.dart';
import 'package:tencent_cloud_chat_sdk/enum/group_member_role_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/history_msg_get_type_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/log_level_enum.dart';
import 'package:tencent_cloud_chat_sdk/enum/offlinePushInfo.dart';
import 'package:tencent_cloud_chat_sdk/enum/receive_message_opt_enum.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_callback.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_conversation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_application.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_check_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_operation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_friend_search_param.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_application_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_operation_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_search_param.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_member_search_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_group_search_param.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_change_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_receipt.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_search_param.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_search_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_search_result_item.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_receive_message_opt_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_full_info.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_user_status.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_value_callback.dart';
import 'package:tencent_cloud_chat_sdk/tencent_im_sdk_plugin.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_message_online_url.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_file_elem.dart';
import 'package:tencent_cloud_chat_sdk/models/v2_tim_sound_elem.dart';
import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';
import 'package:tencent_cloud_chat_vote_plugin/tencent_cloud_chat_vote_plugin.dart';

import 'GenerateUserSig.dart';

class IMServiceManager {
  factory IMServiceManager() => _getInstance();

  static IMServiceManager get instance => _getInstance();
  static IMServiceManager? _instance;
  static int appKey = 1400817501;
  static List<V2TimConversation> currentConversation = [];
  static String userSig = '';
  static String adminID = '10088';

  IMServiceManager._internal() {}

  static IMServiceManager _getInstance() {
    if (_instance == null) {
      _instance = new IMServiceManager._internal();
      onInit();
    }
    return _instance!;
  }

  static clearInstance() {
    _instance = null;
    TencentImSDKPlugin.v2TIMManager.unInitSDK();
  }

  static onInit() async {}

  static loginIM(UserModel userModel) async {
    String key = IMDemoConfig.key;
    int sdkAppId = IMDemoConfig.sdkappid;
    GenerateTestUserSig generateTestUserSig = GenerateTestUserSig(
      sdkappid: sdkAppId,
      key: key,
    );
    String userID = userModel.phone ?? userModel.id?.toString() ?? '';
    String userSig =
        generateTestUserSig.genSig(identifier: userID, expire: 99999);

    var data = await TIMUIKitCore.getInstance().login(
      userID: userID,
      userSig: userSig,
    );
    if (data.code != 0) {
      final option1 = data.desc;
      ToastUtils.toast(
          TIM_t_para("登录失败{{option1}}", "登录失败$option1")(option1: option1));
      return;
    }
    TencentCloudChatVotePlugin.initPlugin();
    setUserInfo(userModel);
    // directToHomePage();
  }

  static setUserInfo(UserModel userModel) async {
    V2TimCallback callback = await TIMUIKitCore.getInstance().setSelfInfo(
        userFullInfo: V2TimUserFullInfo.fromJson({
      "faceUrl": userModel.avatar,
      'nickName': userModel.nickname,
    }));
    if (callback.code == 0) {}
  }

  static Future<V2TimUserFullInfo?> getLoginUserInfo() async {
    final res = await TIMUIKitCore.getSDKInstance().getLoginUser();
    if (res.code == 0) {
      final result = await TIMUIKitCore.getSDKInstance()
          .getUsersInfo(userIDList: [res.data!]);

      if (result.code == 0) {
        return result.data![0];
      }
    }
  }

  //获取群资料
  Future<V2TimGroupInfo?> onGetGroupInfo(String groupID) async {
    V2TimValueCallback<List<V2TimGroupInfoResult>> groupInfo =
        await TencentImSDKPlugin.v2TIMManager
            .getGroupManager()
            .getGroupsInfo(groupIDList: [groupID]);
    return groupInfo.data?.first?.groupInfo;
  }

  Future<V2TimFriendInfo?> onGetUserInfo(String userID) async {
    V2TimValueCallback<List<V2TimFriendInfoResult>> friendsInfo =
        await TencentImSDKPlugin.v2TIMManager
            .getFriendshipManager()
            .getFriendsInfo(userIDList: [userID]);
    if (friendsInfo.data?.isNotEmpty == true) {
      return friendsInfo.data!.first.friendInfo;
    }
  }
}
