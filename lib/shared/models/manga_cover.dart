import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/utils/pair.dart';

part 'manga_cover.freezed.dart';
part 'manga_cover.g.dart';

@freezed
class MangaCover with _$MangaCover {
  const factory MangaCover(
      {required String id,
      required MangaCoverAttributes attributes,
      @JsonKey(fromJson: MangaCover._fromJson)
          required List<Pair<MangaRelationshipType, String>>
              relationships}) = _MangaCover;

  factory MangaCover.fromJson(Map<String, dynamic> json) =>
      _$MangaCoverFromJson(json);

  static List<Pair<MangaRelationshipType, String>> _fromJson(
          List<dynamic> json) =>
      json
          .map((e) => Pair<MangaRelationshipType, String>(
              MangaRelationshipType.fromString(e["type"]), e["id"]))
          .toList();
}

@freezed
class MangaCoverAttributes with _$MangaCoverAttributes {
  const factory MangaCoverAttributes(
      {String? volume,
      required String fileName,
      String? description,
      String? locale,
      required int version,
      required DateTime createdAt,
      required DateTime updatedAt}) = _MangaCoverAttributes;

  factory MangaCoverAttributes.fromJson(Map<String, dynamic> json) =>
      _$MangaCoverAttributesFromJson(json);
}
