import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/tag.dart';
import 'package:mangadex/shared/models/utils/pair.dart';

part 'manga.freezed.dart';

part 'manga.g.dart';

@freezed
class Manga with _$Manga {
  const factory Manga(
      {

      /// Uuid of the Manga
      required String id,
      required MangaAttributes attributes,
      @JsonKey(fromJson: Manga._fromJson)
          required List<Pair<MangaRelationshipType, String>>
              relationships}) = _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);

  static List<Pair<MangaRelationshipType, String>> _fromJson(
          List<dynamic> json) =>
      json
          .map((e) => Pair<MangaRelationshipType, String>(
              MangaRelationshipType.fromString(e["type"]), e["id"]))
          .toList();
}

@freezed
class MangaAttributes with _$MangaAttributes {
  const factory MangaAttributes(
      {required Map<String, String> title,
      required List<Map<String, String>> altTitles,
      required Map<String, String> description,
      required bool isLocked,
      required Map<MangaLinksType, String> links,
      required String originalLanguage,
      String? lastVolume,
      String? lastChapter,
      String? publicationDemographic,
      required MangaStatus status,
      int? year,
      required ContentRating contentRating,
      required bool chapterNumbersResetOnNewVolume,
      required List<String> availableTranslatedLanguages,

      /// Uuid of the latest chapter uploaded
      String? latestUploadedChapter,
      required List<Tag> tags,
      required MangaState state,
      required int version,
      required DateTime createdAt,
      required DateTime updatedAt}) = _MangaAttributes;

  factory MangaAttributes.fromJson(Map<String, dynamic> json) =>
      _$MangaAttributesFromJson(json);
}
