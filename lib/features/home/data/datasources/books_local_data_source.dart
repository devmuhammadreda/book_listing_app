import '../../../../core/services/hive_service.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/entities/results_entity.dart';
import '../../domain/parameters/get_all_books_params.dart';

abstract class BooksLocalBaseDataSource {
  Future<BooksEntity> getBooks(GetAllBooksParams params);
  Future<void> saveBooks(BooksEntity books, int page);
  Future<bool> hasStoredBooks(int page);
  Future<void> clearStoredBooks();
}

class BooksLocalDataSource implements BooksLocalBaseDataSource {
  final HiveService hiveService;
  BooksLocalDataSource(this.hiveService);

  final String _boxName = 'books';
  final String _pageKeyPrefix = 'page_';
  final String _countKey = 'total_count';

  @override
  Future<BooksEntity> getBooks(GetAllBooksParams params) async {
    try {
      final String pageKey = _getPageKey(params.page);
      final List<ResultsEntity>? results =
          await hiveService.get<List<ResultsEntity>>(_boxName, pageKey);

      if (results == null) {
        return BooksEntity();
      }

      List<ResultsEntity> filteredResults = results;

      if (params.search != null && params.search!.isNotEmpty) {
        filteredResults = filteredResults
            .where((book) =>
                book.title
                    ?.toLowerCase()
                    .contains(params.search!.toLowerCase()) ??
                false)
            .toList();
      }

      if (params.topic != null && params.topic!.isNotEmpty) {
        filteredResults = filteredResults
            .where((book) =>
                book.subjects?.any((subject) => subject
                    .toLowerCase()
                    .contains(params.topic!.toLowerCase())) ??
                false)
            .toList();
      }

      if (params.limit != null && filteredResults.length > params.limit!) {
        filteredResults = filteredResults.sublist(0, params.limit!);
      }

      final int? totalCount = await hiveService.get<int>(_boxName, _countKey);

      String? next;
      String? previous;

      if (await hasStoredBooks(params.page + 1)) {
        next = 'page=${params.page + 1}';
      }

      if (params.page > 1 && await hasStoredBooks(params.page - 1)) {
        previous = 'page=${params.page - 1}';
      }

      return BooksEntity(
        count: totalCount,
        next: next,
        previous: previous,
        results: filteredResults,
      );
    } catch (e) {
      throw Exception('Failed to get books from local storage: $e');
    }
  }

  @override
  Future<void> saveBooks(BooksEntity books, int page) async {
    try {
      final String pageKey = _getPageKey(page);

      if (books.results != null) {
        await hiveService.add<List<ResultsEntity>>(
            _boxName, pageKey, books.results!);
      }

      if (books.count != null) {
        await hiveService.add<int>(_boxName, _countKey, books.count!);
      }
    } catch (e) {
      throw Exception('Failed to save books to local storage: $e');
    }
  }

  @override
  Future<bool> hasStoredBooks(int page) async {
    try {
      final String pageKey = _getPageKey(page);
      final results =
          await hiveService.get<List<ResultsEntity>>(_boxName, pageKey);
      return results != null && results.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearStoredBooks() async {
    try {
      await hiveService.clearBox(_boxName);
    } catch (e) {
      throw Exception('Failed to clear stored books: $e');
    }
  }

  String _getPageKey(int page) {
    return '$_pageKeyPrefix$page';
  }
}
