import '../../domain/entities/formats_entity.dart';

class FormatsModel extends FormatEntity {
  FormatsModel({
    super.textHtml,
    super.applicationEpubZip,
    super.applicationXMobipocketEbook,
    super.applicationRdfXml,
    super.imageJpeg,
    super.textPlainCharsetUsAscii,
    super.applicationOctetStream,
  });

  FormatsModel.fromJson(Map<String, dynamic> json) {
    if (json["text/html"] is String) {
      textHtml = json["text/html"];
    }
    if (json["application/epub+zip"] is String) {
      applicationEpubZip = json["application/epub+zip"];
    }
    if (json["application/x-mobipocket-ebook"] is String) {
      applicationXMobipocketEbook = json["application/x-mobipocket-ebook"];
    }
    if (json["application/rdf+xml"] is String) {
      applicationRdfXml = json["application/rdf+xml"];
    }
    if (json["image/jpeg"] is String) {
      imageJpeg = json["image/jpeg"];
    }
    if (json["text/plain; charset=us-ascii"] is String) {
      textPlainCharsetUsAscii = json["text/plain; charset=us-ascii"];
    }
    if (json["application/octet-stream"] is String) {
      applicationOctetStream = json["application/octet-stream"];
    }
  }

  static List<FormatEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map((e) => FormatsModel.fromJson(e)).toList();
  }
}
