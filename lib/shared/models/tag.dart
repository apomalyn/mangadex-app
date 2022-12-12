import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';

part 'tag.freezed.dart';

part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  const factory Tag({required String id, required TagAttributes attributes}) =
      _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}

@freezed
class TagAttributes with _$TagAttributes {
  const factory TagAttributes(
      {required Map<String, String> name,
      required Map<String, String> description,
      required TagGroup group,
      required int version}) = _TagAttributes;

  factory TagAttributes.fromJson(Map<String, dynamic> json) =>
      _$TagAttributesFromJson(json);
}
