import 'package:freezed_annotation/freezed_annotation.dart';

enum MangaStatus { completed, ongoing, cancelled, hiatus }

enum PublicationDemographic { shounen, shoujo, josei, seinen }

enum ContentRating { safe, suggestive, erotica, pornographic }

enum MangaState { draft, submitted, published, rejected }

enum TagGroup { content, format, genre, theme }

enum ResponseResult { ok, error }

@JsonEnum(fieldRename: FieldRename.snake)
enum ReadingListType {
  reading,
  onHold,
  planToRead,
  dropped,
  reReading,
  completed;
}

@JsonEnum(valueField: 'value')
enum MangaRelationshipType {
  manga("manga"),
  chapter("chapter"),
  coverArt("cover_art"),
  author("author"),
  artist("artist"),
  scanlationGroup("scanlation_group"),
  tag("tag"),
  user("user"),
  customList("custom_list");

  const MangaRelationshipType(this.value);

  final String value;

  static MangaRelationshipType fromString(String value) =>
      MangaRelationshipType.values
          .firstWhere((element) => element.value == value);
}

@JsonEnum(valueField: 'code')
enum MangaLinksType {
  anilist("al"),
  animeplanet("ap"),
  bookwalker("bw"),
  mangaupdates("mu"),
  novelupdates("nu"),
  kitsu("kt"),
  amazon("amz"),
  ebookjapan("ebj"),
  myanimelist("mal"),
  CDJapan("cdj"),
  raw("raw"),
  engtl("engtl");

  const MangaLinksType(this.code);

  final String code;
}
