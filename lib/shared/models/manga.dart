import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/relationship.dart';
import 'package:mangadex/shared/models/tag.dart';

part 'manga.freezed.dart';

part 'manga.g.dart';

@freezed
class Manga with _$Manga {
  const factory Manga(
          {required String id,
          required MangaAttributes attributes,
          @RelationshipConverter() required List<Relationship> relationships}) =
      _Manga;

  factory Manga.fromJson(Map<String, dynamic> json) => _$MangaFromJson(json);
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
