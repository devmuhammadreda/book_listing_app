import 'package:hive_ce_flutter/hive_flutter.dart';

import 'features/home/domain/entities/authors_entity.dart';
import 'features/home/domain/entities/book_entity.dart';
import 'features/home/domain/entities/formats_entity.dart';
import 'features/home/domain/entities/results_entity.dart';

void registerAdapters() {
  Hive.registerAdapter(BooksEntityAdapter());
  Hive.registerAdapter(ResultsEntityAdapter());
  Hive.registerAdapter(AuthorEntityAdapter());
  Hive.registerAdapter(FormatEntityAdapter());
}

class BooksEntityAdapter extends TypeAdapter<BooksEntity> {
  @override
  final int typeId = 0;

  @override
  BooksEntity read(BinaryReader reader) {
    final count = reader.readInt();
    final next = reader.readString();
    final previous = reader.readString();
    final List<ResultsEntity> results =
        List<ResultsEntity>.from(reader.readList());
    return BooksEntity(
      count: count,
      next: next.isEmpty ? null : next,
      previous: previous.isEmpty ? null : previous,
      results: results,
    );
  }

  @override
  void write(BinaryWriter writer, BooksEntity obj) {
    writer.writeInt(obj.count ?? 0);
    writer.writeString(obj.next ?? '');
    writer.writeString(obj.previous ?? '');
    writer.writeList(obj.results ?? []);
  }
}

class ResultsEntityAdapter extends TypeAdapter<ResultsEntity> {
  @override
  final int typeId = 1;

  @override
  ResultsEntity read(BinaryReader reader) {
    final id = reader.readInt();
    final title = reader.readString();
    final List<AuthorEntity> authors =
        List<AuthorEntity>.from(reader.readList());
    final List<String> summaries = List<String>.from(reader.readList());
    final List<dynamic> translators = reader.readList();
    final List<String> subjects = List<String>.from(reader.readList());
    final List<String> bookshelves = List<String>.from(reader.readList());
    final List<String> languages = List<String>.from(reader.readList());
    final copyright = reader.readBool();
    final mediaType = reader.readString();
    final formats = reader.read() as FormatEntity;
    final downloadCount = reader.readInt();

    return ResultsEntity(
      id: id,
      title: title.isEmpty ? null : title,
      authors: authors.isEmpty ? null : authors,
      summaries: summaries.isEmpty ? null : summaries,
      translators: translators.isEmpty ? null : translators,
      subjects: subjects.isEmpty ? null : subjects,
      bookshelves: bookshelves.isEmpty ? null : bookshelves,
      languages: languages.isEmpty ? null : languages,
      copyright: copyright,
      mediaType: mediaType.isEmpty ? null : mediaType,
      formats: formats,
      downloadCount: downloadCount,
    );
  }

  @override
  void write(BinaryWriter writer, ResultsEntity obj) {
    writer.writeInt(obj.id ?? 0);
    writer.writeString(obj.title ?? '');
    writer.writeList(obj.authors ?? []);
    writer.writeList(obj.summaries ?? []);
    writer.writeList(obj.translators ?? []);
    writer.writeList(obj.subjects ?? []);
    writer.writeList(obj.bookshelves ?? []);
    writer.writeList(obj.languages ?? []);
    writer.writeBool(obj.copyright ?? false);
    writer.writeString(obj.mediaType ?? '');
    writer.write(obj.formats ?? FormatEntity());
    writer.writeInt(obj.downloadCount ?? 0);
  }
}

class AuthorEntityAdapter extends TypeAdapter<AuthorEntity> {
  @override
  final int typeId = 2;

  @override
  AuthorEntity read(BinaryReader reader) {
    final name = reader.readString();
    final birthYear = reader.readInt();
    final deathYear = reader.readInt();

    return AuthorEntity(
      name: name.isEmpty ? null : name,
      birthYear: birthYear == -1 ? null : birthYear,
      deathYear: deathYear == -1 ? null : deathYear,
    );
  }

  @override
  void write(BinaryWriter writer, AuthorEntity obj) {
    writer.writeString(obj.name ?? '');
    writer.writeInt(obj.birthYear ?? -1);
    writer.writeInt(obj.deathYear ?? -1);
  }
}

class FormatEntityAdapter extends TypeAdapter<FormatEntity> {
  @override
  final int typeId = 3;

  @override
  FormatEntity read(BinaryReader reader) {
    final textHtml = reader.readString();
    final applicationEpubZip = reader.readString();
    final applicationXMobipocketEbook = reader.readString();
    final applicationRdfXml = reader.readString();
    final imageJpeg = reader.readString();
    final textPlainCharsetUsAscii = reader.readString();
    final applicationOctetStream = reader.readString();

    return FormatEntity(
      textHtml: textHtml.isEmpty ? null : textHtml,
      applicationEpubZip:
          applicationEpubZip.isEmpty ? null : applicationEpubZip,
      applicationXMobipocketEbook: applicationXMobipocketEbook.isEmpty
          ? null
          : applicationXMobipocketEbook,
      applicationRdfXml: applicationRdfXml.isEmpty ? null : applicationRdfXml,
      imageJpeg: imageJpeg.isEmpty ? null : imageJpeg,
      textPlainCharsetUsAscii:
          textPlainCharsetUsAscii.isEmpty ? null : textPlainCharsetUsAscii,
      applicationOctetStream:
          applicationOctetStream.isEmpty ? null : applicationOctetStream,
    );
  }

  @override
  void write(BinaryWriter writer, FormatEntity obj) {
    writer.writeString(obj.textHtml ?? '');
    writer.writeString(obj.applicationEpubZip ?? '');
    writer.writeString(obj.applicationXMobipocketEbook ?? '');
    writer.writeString(obj.applicationRdfXml ?? '');
    writer.writeString(obj.imageJpeg ?? '');
    writer.writeString(obj.textPlainCharsetUsAscii ?? '');
    writer.writeString(obj.applicationOctetStream ?? '');
  }
}
