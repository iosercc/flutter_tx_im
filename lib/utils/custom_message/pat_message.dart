import 'dart:convert';

import 'package:tencent_cloud_chat_uikit/tencent_cloud_chat_uikit.dart';

class PatMessage {
  String? fromUserId;
  String? fromNickName;
  String? toNickName;
  String? toUserId;
  String? patString;

  PatMessage.fromJSON(Map json) {
    fromUserId = json["fromUserId"];
    fromNickName = json["fromNickName"];
    toNickName = json["toNickName"];
    toUserId = json["toUserId"];
    patString = json["patString"];
  }
}

PatMessage? getPatMessage(V2TimCustomElem? customElem) {
  try {
    if (customElem?.data != null) {
      final customMessage = jsonDecode(customElem!.data!);
      return PatMessage.fromJSON(customMessage);
    }
    return null;
  } catch (err) {
    return null;
  }
}