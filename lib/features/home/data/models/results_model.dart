import '../../domain/entities/results_entity.dart';
import 'author_model.dart';
import 'formats_model.dart';

class ResultsModel extends ResultsEntity {
  ResultsModel({
    super.id,
    super.title,
    super.authors,
    super.summaries,
    super.translators,
    super.subjects,
    super.bookshelves,
    super.languages,
    super.copyright,
    super.mediaType,
    super.formats,
    super.downloadCount,
  });

  static List<ResultsEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(ResultsModel.fromJson).toList();
  }

  ResultsModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is num) {
      id = (json["id"] as num).toInt();
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["authors"] is List) {
      authors = json["authors"] == null
          ? null
          : (json["authors"] as List)
              .map((e) => AuthorModel.fromJson(e))
              .toList();
    }
    if (json["summaries"] is List) {
      summaries = json["summaries"] == null
          ? null
          : List<String>.from(json["summaries"]);
    }
    if (json["translators"] is List) {
      translators = json["translators"] ?? [];
    }
    if (json["subjects"] is List) {
      subjects =
          json["subjects"] == null ? null : List<String>.from(json["subjects"]);
    }
    if (json["bookshelves"] is List) {
      bookshelves = json["bookshelves"] == null
          ? null
          : List<String>.from(json["bookshelves"]);
    }
    if (json["languages"] is List) {
      languages = json["languages"] == null
          ? null
          : List<String>.from(json["languages"]);
    }
    if (json["copyright"] is bool) {
      copyright = json["copyright"];
    }
    if (json["media_type"] is String) {
      mediaType = json["media_type"];
    }
    if (json["formats"] is Map) {
      formats = json["formats"] == null
          ? null
          : FormatsModel.fromJson(json["formats"]);
    }
    if (json["download_count"] is num) {
      downloadCount = (json["download_count"] as num).toInt();
    }
  }
}
