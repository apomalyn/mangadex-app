import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex/shared/models/enums.dart';
import 'package:mangadex/shared/models/manga.dart';
import 'package:mangadex/shared/models/manga_cover.dart';

part 'relationship.freezed.dart';

part 'relationship.g.dart';

@Freezed(genericArgumentFactories: true)
class Relationship<T> with _$Relationship<T> {
  const factory Relationship(
      {required MangaRelationshipType type,
      required String id,
      T? attributes}) = _Relationship;

  factory Relationship.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$RelationshipFromJson(json, fromJsonT);
}

class RelationshipConverter
    implements JsonConverter<Relationship, Map<String, dynamic>> {
  const RelationshipConverter();

  @override
  Relationship fromJson(Map<String, dynamic> json) {
    switch (MangaRelationshipType.fromString(json["type"])) {
      case MangaRelationshipType.coverArt:
        return Relationship.fromJson(
            json,
            (partial) =>
                MangaCoverAttributes.fromJson(partial as Map<String, dynamic>));
      case MangaRelationshipType.manga:
        return Relationship.fromJson(
            json,
            (partial) =>
                MangaAttributes.fromJson(partial as Map<String, dynamic>));
      default:
        return Relationship.fromJson(json, (partial) => null);
    }
  }

  @override
  Map<String, dynamic> toJson(Relationship<dynamic> data) {
    switch (data.type) {
      case MangaRelationshipType.coverArt:
        return data.toJson((partial) => partial.toJson());
      case MangaRelationshipType.manga:
        return data.toJson((partial) => data.attributes.toJson());
      default:
        return data.toJson((partial) => null);
    }
  }
}
