class FormatEntity {
  String? textHtml;
  String? applicationEpubZip;
  String? applicationXMobipocketEbook;
  String? applicationRdfXml;
  String? imageJpeg;
  String? textPlainCharsetUsAscii;
  String? applicationOctetStream;

  FormatEntity({
    this.textHtml,
    this.applicationEpubZip,
    this.applicationXMobipocketEbook,
    this.applicationRdfXml,
    this.imageJpeg,
    this.textPlainCharsetUsAscii,
    this.applicationOctetStream,
  });

  FormatEntity copyWith({
    String? textHtml,
    String? applicationEpubZip,
    String? applicationXMobipocketEbook,
    String? applicationRdfXml,
    String? imageJpeg,
    String? textPlainCharsetUsAscii,
    String? applicationOctetStream,
  }) {
    return FormatEntity(
      textHtml: textHtml ?? this.textHtml,
      applicationEpubZip: applicationEpubZip ?? this.applicationEpubZip,
      applicationXMobipocketEbook:
          applicationXMobipocketEbook ?? this.applicationXMobipocketEbook,
      applicationRdfXml: applicationRdfXml ?? this.applicationRdfXml,
      imageJpeg: imageJpeg ?? this.imageJpeg,
      textPlainCharsetUsAscii:
          textPlainCharsetUsAscii ?? this.textPlainCharsetUsAscii,
      applicationOctetStream:
          applicationOctetStream ?? this.applicationOctetStream,
    );
  }

  
}
