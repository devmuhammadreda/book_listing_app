import 'results_entity.dart';

class BooksEntity {
  int? count;
  String? next;
  String? previous;
  List<ResultsEntity>? results;

  BooksEntity({this.count, this.next, this.previous, this.results});
  BooksEntity copyWith({
    int? count,
    String? next,
    String? previous,
    List<ResultsEntity>? results,
  }) =>
      BooksEntity(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );
}
