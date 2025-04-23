import 'authors_entity.dart';
import 'formats_entity.dart';

class ResultsEntity {
  int? id;
  String? title;
  List<AuthorEntity>? authors;
  List<String>? summaries;
  List<dynamic>? translators;
  List<String>? subjects;
  List<String>? bookshelves;
  List<String>? languages;
  bool? copyright;
  String? mediaType;
  FormatEntity? formats;
  int? downloadCount;

  ResultsEntity({
    this.id,
    this.title,
    this.authors,
    this.summaries,
    this.translators,
    this.subjects,
    this.bookshelves,
    this.languages,
    this.copyright,
    this.mediaType,
    this.formats,
    this.downloadCount,
  });

  ResultsEntity copyWith({
    int? id,
    String? title,
    List<AuthorEntity>? authors,
    List<String>? summaries,
    List<dynamic>? translators,
    List<String>? subjects,
    List<String>? bookshelves,
    List<String>? languages,
    bool? copyright,
    String? mediaType,
    FormatEntity? formats,
    int? downloadCount,
  }) =>
      ResultsEntity(
        id: id ?? this.id,
        title: title ?? this.title,
        authors: authors ?? this.authors,
        summaries: summaries ?? this.summaries,
        translators: translators ?? this.translators,
        subjects: subjects ?? this.subjects,
        bookshelves: bookshelves ?? this.bookshelves,
        languages: languages ?? this.languages,
        copyright: copyright ?? this.copyright,
        mediaType: mediaType ?? this.mediaType,
        formats: formats ?? this.formats,
        downloadCount: downloadCount ?? this.downloadCount,
      );
}
