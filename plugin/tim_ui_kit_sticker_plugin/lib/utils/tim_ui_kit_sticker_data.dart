class CustomStickerPackage {
  CustomStickerPackage({
    required this.name,
    this.baseUrl,
    this.isEmoji = false,
    this.isDefaultEmoji = false,
    required this.stickerList,
    required this.menuItem,
  });

  final String name;
  final String? baseUrl;
  final List<CustomSticker> stickerList;
  final CustomSticker menuItem;
  bool? isEmoji;
  bool isDefaultEmoji;

  bool get isCustomSticker => menuItem.unicode == null;

  bool get isCustomEmojiSticker => isEmoji == true;

  bool get isDefaultEmojiSticker => isDefaultEmoji == true;
}

class CustomSticker {
  const CustomSticker(
      {required this.name,
      required this.index,
      this.url,
      this.unicode,
      this.id});

  final int? unicode;
  final String name;
  final int index;
  final String? url;
  final int? id;

  //fromJson
  factory CustomSticker.fromJson(Map<String, dynamic> json, int index) {
    return CustomSticker(
      name: json['name'] ?? json['emoji_url'],
      index: index,
      url: json['emoji_url'],
      unicode: json['unicode'],
      id: json['id'],
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['index'] = index;
    data['emoji_url'] = url;
    data['unicode'] = unicode;
    data['id'] = id;
    return data;
  }
}

class StickerListUtil {
  StickerListUtil(this.customStickerList);

  final List<Map<String, dynamic>> customStickerList;

  StickerListUtil._(this.customStickerList);

  static StickerListUtil? _instance;

  StickerListUtil get instance =>
      _instance ??= StickerListUtil._(customStickerList);
}
