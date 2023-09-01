import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:image_editor/image_editor.dart';
import 'package:path_provider/path_provider.dart';

class ImageEditorView extends StatefulWidget {
  final String filePath;

  const ImageEditorView({super.key, required this.filePath});
  @override
  _ImageEditorViewState createState() => _ImageEditorViewState();
}

class _ImageEditorViewState extends State<ImageEditorView> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();
  bool _cropping = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: ExtendedImage.file(
          File(widget.filePath),
          fit: BoxFit.contain,
          mode: ExtendedImageMode.editor,
          enableLoadState: true,
          extendedImageEditorKey: editorKey,
          cacheRawData: true,
          // maxBytes: 1024 * 200,
          initEditorConfigHandler: (ExtendedImageState? state) {
            return EditorConfig(
                maxScale: 4.0,
                cropRectPadding: const EdgeInsets.all(20.0),
                hitTestSize: 20.0,
                initCropRectType: InitCropRectType.imageRect,
                cropAspectRatio: CropAspectRatios.ratio1_1,
                editActionDetailsIsChanged: (EditActionDetails? details) {
                  //print(details?.totalScale);
                });
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.crop, color: Colors.white),
            onPressed: () {
              cropImage();
            }),
      ),
    );
  }

  Future<void> cropImage() async {
    if (_cropping) {
      return;
    }
    _cropping = true;
    try {
      final Uint8List fileData = Uint8List.fromList((await cropImageDataWithNativeLibrary(state: editorKey.currentState!))!);
      Directory temp = await getTemporaryDirectory();
      File file = await File('${temp.path}/cropped_image.jpg').create();
      file.writeAsBytesSync(fileData);
      Navigator.pop(context, file.path);
      // Get.back(result: file.path);
    } finally {
      _cropping = false;
    }
  }

  Future<Uint8List?> cropImageDataWithNativeLibrary({required ExtendedImageEditorState state}) async {
    print('native library start cropping');
    Rect cropRect = state.getCropRect()!;
    if (state.widget.extendedImageState.imageProvider is ExtendedResizeImage) {
      final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(state.rawImageData);
      final ImageDescriptor descriptor = await ImageDescriptor.encoded(buffer);

      final double widthRatio = descriptor.width / state.image!.width;
      final double heightRatio = descriptor.height / state.image!.height;
      cropRect = Rect.fromLTRB(
        cropRect.left * widthRatio,
        cropRect.top * heightRatio,
        cropRect.right * widthRatio,
        cropRect.bottom * heightRatio,
      );
    }

    final EditActionDetails action = state.editAction!;

    final int rotateAngle = action.rotateAngle.toInt();
    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List img = state.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    if (action.needCrop) {
      option.addOption(ClipOption.fromRect(cropRect));
    }

    if (action.needFlip) {
      option.addOption(FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    }

    if (action.hasRotateAngle) {
      option.addOption(RotateOption(rotateAngle));
    }

    final DateTime start = DateTime.now();
    final Uint8List? result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    print('${DateTime.now().difference(start)} ：total time');
    return result;
  }
}
