import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';

// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tencent_cloud_chat_demo/network/api.dart';
import 'package:tencent_cloud_chat_demo/network/http_extension.dart';
import 'package:tencent_cloud_chat_demo/network/network.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../src/widgets/image_editor_view.dart';

class AvatarUtils {
  /// 选择图片
  /// [sourceType] 0:拍照 1:相册
  /// [onSuccess] 上传成功回调
  /// [onError] 上传失败回调
  /// [onLimit] 上传图片大小超过限制回调
  static chooseImageFromLocal(BuildContext context, int sourceType,
      {required Function onSuccess,
      required Function onError,
      Function? onLimit}) async {
    try {
      List<AssetEntity>? files = await AssetPicker.pickAssets(context,
          pickerConfig: const AssetPickerConfig(
              maxAssets: 1, requestType: RequestType.image));
      // XFile? pickedFile = await AssetPicker().pickImage(
      //   source: sourceType == 0 ? ImageSource.camera : ImageSource.gallery,
      // );

      if (files != null) {
        File? pickedFile = await files.first.file;
        if (pickedFile == null) return;
        int fileSize = await pickedFile!.length();
        if (fileSize > 1024 * 1024 * 3) {
          // 上传图片大小超过限制 最大3M
          onLimit?.call();
          return;
        }
        //裁剪图片
        String? resultPath = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ImageEditorView(filePath: pickedFile!.path)));
        if (resultPath != null) {
          pickedFile = File(resultPath);
          fileSize = await pickedFile!.length();
          print('压缩前fileSize:$fileSize');
          int compressCount = 0;
          // 图片大于200kb，压缩
          while (fileSize > 200 * 1024) {
            compressCount++;
            if (compressCount == 4) {
              // 压缩次数超过3次，不再压缩
              break;
            }
            pickedFile = (await FlutterImageCompress.compressAndGetFile(
              pickedFile?.path ?? '',
              '${Directory.systemTemp.path}/userAvatar${DateTime.now().millisecondsSinceEpoch}.jpg',
              quality: 30,
            ));
            if (pickedFile != null) {
              fileSize = await pickedFile!.length();
              print('压缩后fileSize:$fileSize');
            } else {
              fileSize = 0;
              onError.call('');
            }
          }
          if (fileSize > 0 && pickedFile != null) {
            uploadAvatar(pickedFile!.path,
                onSuccess: onSuccess, onError: onError);
          }
        }
      } else {
        onError.call('');
      }
    } catch (e) {
      onError.call('');
    }
  }

  static uploadAvatar(String filePath,
      {required Function onSuccess, required Function onError}) async {
    Map<String, dynamic> params = {
      'image': await MultipartFile.fromFile(filePath,
          contentType: MediaType.parse("image/png")),
    };
    ResponseData responseData =
        await Api.uploadImage.post(params, isJson: false);
    if (responseData.isSuccess()) {
      if (responseData.data['url'] == null) {
        onError.call('');
        return;
      }
      onSuccess.call(responseData.data['url']);
    } else {
      onError.call('');
    }
  }
}
