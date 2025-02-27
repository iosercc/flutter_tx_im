import 'package:json_annotation/json_annotation.dart';

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Emoji _$EmojiFromJson(Map<String, dynamic> json) {
  return Emoji(
    json['name'] as String,
    json['unicode'] as int,
  );
}

Map<String, dynamic> _$EmojiToJson(Emoji instance) => <String, dynamic>{
      'name': instance.name,
      'unicode': instance.unicode,
    };

@JsonSerializable()
class Emoji extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'unicode')
  int unicode;

  Emoji(
    this.name,
    this.unicode,
  );

  factory Emoji.fromJson(Map<String, dynamic> srcJson) =>
      _$EmojiFromJson(srcJson);

  Map<String, dynamic> toJson() => _$EmojiToJson(this);
}

List<Map<String, Object>> emojiData = [
  {"name": "GRINNING FACE WITH SMILING EYES", "unicode": 128513},
  {"name": "FACE WITH TEARS OF JOY", "unicode": 128514},
  {"name": "SMILING FACE WITH OPEN MOUTH", "unicode": 128515},
  {"name": "SMILING FACE WITH OPEN MOUTH AND SMILING EYES", "unicode": 128516},
  {"name": "SMILING FACE WITH OPEN MOUTH AND COLD SWEAT", "unicode": 128517},
  {
    "name": "SMILING FACE WITH OPEN MOUTH AND TIGHTLY-CLOSED EYES",
    "unicode": 128518
  },
  {"name": "WINKING FACE", "unicode": 128521},
  {"name": "SMILING FACE WITH SMILING EYES", "unicode": 128522},
  {"name": "FACE SAVOURING DELICIOUS FOOD", "unicode": 128523},
  {"name": "RELIEVED FACE", "unicode": 128524},
  {"name": "SMILING FACE WITH HEART-SHAPED EYES", "unicode": 128525},
  {"name": "SMIRKING FACE", "unicode": 128527},
  {"name": "UNAMUSED FACE", "unicode": 128530},
  {"name": "FACE WITH COLD SWEAT", "unicode": 128531},
  {"name": "PENSIVE FACE", "unicode": 128532},
  {"name": "CONFOUNDED FACE", "unicode": 128534},
  {"name": "FACE THROWING A KISS", "unicode": 128536},
  {"name": "KISSING FACE WITH CLOSED EYES", "unicode": 128538},
  {"name": "FACE WITH STUCK-OUT TONGUE AND WINKING EYE", "unicode": 128540},
  {
    "name": "FACE WITH STUCK-OUT TONGUE AND TIGHTLY-CLOSED EYES",
    "unicode": 128541
  },
  {"name": "DISAPPOINTED FACE", "unicode": 128542},
  {"name": "ANGRY FACE", "unicode": 128544},
  {"name": "POUTING FACE", "unicode": 128545},
  {"name": "CRYING FACE", "unicode": 128546},
  {"name": "PERSEVERING FACE", "unicode": 128547},
  {"name": "FACE WITH LOOK OF TRIUMPH", "unicode": 128548},
  {"name": "DISAPPOINTED BUT RELIEVED FACE", "unicode": 128549},
  {"name": "FEARFUL FACE", "unicode": 128552},
  {"name": "WEARY FACE", "unicode": 128553},
  {"name": "SLEEPY FACE", "unicode": 128554},
  {"name": "TIRED FACE", "unicode": 128555},
  {"name": "LOUDLY CRYING FACE", "unicode": 128557},
  {"name": "FACE WITH OPEN MOUTH AND COLD SWEAT", "unicode": 128560},
  {"name": "FACE SCREAMING IN FEAR", "unicode": 128561},
  {"name": "ASTONISHED FACE", "unicode": 128562},
  {"name": "FLUSHED FACE", "unicode": 128563},
  {"name": "DIZZY FACE", "unicode": 128565},
  {"name": "FACE WITH MEDICAL MASK", "unicode": 128567},
  {"name": "GRINNING CAT FACE WITH SMILING EYES", "unicode": 128568},
  {"name": "CAT FACE WITH TEARS OF JOY", "unicode": 128569},
  {"name": "SMILING CAT FACE WITH OPEN MOUTH", "unicode": 128570},
  {"name": "SMILING CAT FACE WITH HEART-SHAPED EYES", "unicode": 128571},
  {"name": "CAT FACE WITH WRY SMILE", "unicode": 128572},
  {"name": "KISSING CAT FACE WITH CLOSED EYES", "unicode": 128573},
  {"name": "POUTING CAT FACE", "unicode": 128574},
  {"name": "CRYING CAT FACE", "unicode": 128575},
  {"name": "WEARY CAT FACE", "unicode": 128576},
  {"name": "FACE WITH NO GOOD GESTURE", "unicode": 128581},
  {"name": "FACE WITH OK GESTURE", "unicode": 128582},
  {"name": "PERSON BOWING DEEPLY", "unicode": 128583},
  {"name": "SEE-NO-EVIL MONKEY", "unicode": 128584},
  {"name": "HEAR-NO-EVIL MONKEY", "unicode": 128585},
  {"name": "SPEAK-NO-EVIL MONKEY", "unicode": 128586},
  {"name": "HAPPY PERSON RAISING ONE HAND", "unicode": 128587},
  {"name": "PERSON RAISING BOTH HANDS IN CELEBRATION", "unicode": 128588},
  {"name": "PERSON FROWNING", "unicode": 128589},
  {"name": "PERSON WITH POUTING FACE", "unicode": 128590},
  {"name": "PERSON WITH FOLDED HANDS", "unicode": 128591},
  {"name": "BLACK SCISSORS", "unicode": 9986},
  {"name": "WHITE HEAVY CHECK MARK", "unicode": 9989},
  {"name": "AIRPLANE", "unicode": 9992},
  {"name": "ENVELOPE", "unicode": 9993},
  {"name": "RAISED FIST", "unicode": 9994},
  {"name": "RAISED HAND", "unicode": 9995},
  {"name": "VICTORY HAND", "unicode": 9996},
  {"name": "PENCIL", "unicode": 9999},
  {"name": "BLACK NIB", "unicode": 10002},
  {"name": "HEAVY CHECK MARK", "unicode": 10004},
  {"name": "HEAVY MULTIPLICATION X", "unicode": 10006},
  {"name": "SPARKLES", "unicode": 10024},
  {"name": "EIGHT SPOKED ASTERISK", "unicode": 10035},
  {"name": "EIGHT POINTED BLACK STAR", "unicode": 10036},
  {"name": "SNOWFLAKE", "unicode": 10052},
  {"name": "SPARKLE", "unicode": 10055},
  {"name": "CROSS MARK", "unicode": 10060},
  {"name": "NEGATIVE SQUARED CROSS MARK", "unicode": 10062},
  {"name": "BLACK QUESTION MARK ORNAMENT", "unicode": 10067},
  {"name": "WHITE QUESTION MARK ORNAMENT", "unicode": 10068},
  {"name": "WHITE EXCLAMATION MARK ORNAMENT", "unicode": 10069},
  {"name": "HEAVY EXCLAMATION MARK SYMBOL", "unicode": 10071},
  {"name": "HEAVY BLACK HEART", "unicode": 10084},
  {"name": "HEAVY PLUS SIGN", "unicode": 10133},
  {"name": "HEAVY MINUS SIGN", "unicode": 10134},
  {"name": "HEAVY DIVISION SIGN", "unicode": 10135},
  {"name": "BLACK RIGHTWARDS ARROW", "unicode": 10145},
  {"name": "CURLY LOOP", "unicode": 10160},
  {"name": "ROCKET", "unicode": 128640},
  {"name": "RAILWAY CAR", "unicode": 128643},
  {"name": "HIGH-SPEED TRAIN", "unicode": 128644},
  {"name": "HIGH-SPEED TRAIN WITH BULLET NOSE", "unicode": 128645},
  {"name": "METRO", "unicode": 128647},
  {"name": "STATION", "unicode": 128649},
  {"name": "BUS", "unicode": 128652},
  {"name": "BUS STOP", "unicode": 128655},
  {"name": "AMBULANCE", "unicode": 128657},
  {"name": "FIRE ENGINE", "unicode": 128658},
  {"name": "POLICE CAR", "unicode": 128659},
  {"name": "TAXI", "unicode": 128661},
  {"name": "AUTOMOBILE", "unicode": 128663},
  {"name": "RECREATIONAL VEHICLE", "unicode": 128665},
  {"name": "DELIVERY TRUCK", "unicode": 128666},
  {"name": "SHIP", "unicode": 128674},
  {"name": "SPEEDBOAT", "unicode": 128676},
  {"name": "HORIZONTAL TRAFFIC LIGHT", "unicode": 128677},
  {"name": "CONSTRUCTION SIGN", "unicode": 128679},
  {"name": "POLICE CARS REVOLVING LIGHT", "unicode": 128680},
  {"name": "TRIANGULAR FLAG ON POST", "unicode": 128681},
  {"name": "DOOR", "unicode": 128682},
  {"name": "NO ENTRY SIGN", "unicode": 128683},
  {"name": "SMOKING SYMBOL", "unicode": 128684},
  {"name": "NO SMOKING SYMBOL", "unicode": 128685},
  {"name": "BICYCLE", "unicode": 128690},
  {"name": "PEDESTRIAN", "unicode": 128694},
  {"name": "MENS SYMBOL", "unicode": 128697},
  {"name": "WOMENS SYMBOL", "unicode": 128698},
  {"name": "RESTROOM", "unicode": 128699},
  {"name": "BABY SYMBOL", "unicode": 128700},
  {"name": "TOILET", "unicode": 128701},
  {"name": "WATER CLOSET", "unicode": 128702},
  {"name": "BATH", "unicode": 128704},
  {"name": "CIRCLED LATIN CAPITAL LETTER M", "unicode": 9410},
  {"name": "NEGATIVE SQUARED LATIN CAPITAL LETTER A", "unicode": 127344},
  {"name": "NEGATIVE SQUARED LATIN CAPITAL LETTER B", "unicode": 127345},
  {"name": "NEGATIVE SQUARED LATIN CAPITAL LETTER O", "unicode": 127358},
  {"name": "NEGATIVE SQUARED LATIN CAPITAL LETTER P", "unicode": 127359},
  {"name": "NEGATIVE SQUARED AB", "unicode": 127374},
  {"name": "SQUARED CL", "unicode": 127377},
  {"name": "SQUARED COOL", "unicode": 127378},
  {"name": "SQUARED FREE", "unicode": 127379},
  {"name": "SQUARED ID", "unicode": 127380},
  {"name": "SQUARED NEW", "unicode": 127381},
];
