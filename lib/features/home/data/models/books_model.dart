import 'package:book_listing_app/features/home/domain/entities/book_entity.dart';

import 'results_model.dart';

class BooksModel extends BooksEntity {
  BooksModel({
    super.count,
    super.next,
    super.previous,
    super.results,
  });

  BooksModel.fromJson(Map<String, dynamic> json) {
    if (json["count"] is num) {
      count = (json["count"] as num).toInt();
    }
    if (json["next"] is String) {
      next = json["next"];
    }
    if (json["previous"] is String) {
      previous = json["previous"];
    }
    if (json["results"] is List) {
      results = json["results"] == null
          ? null
          : (json["results"] as List)
              .map((e) => ResultsModel.fromJson(e))
              .toList();
    }
  }

  static List<BooksEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map(BooksModel.fromJson).toList();
  }
}
