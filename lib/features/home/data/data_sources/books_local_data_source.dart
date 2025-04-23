import '../../../../core/error/exceptions.dart';
import '../../../../core/services/hive_service.dart';
import '../../domain/entities/results_entity.dart';

abstract class BooksLocalBaseDataSource {
  Future<List<ResultsEntity>> getBooks();
  Future<void> saveBooks(List<ResultsEntity> books);
  Future<List<ResultsEntity>> searchBooks(String query);
}

class BooksLocalDataSource implements BooksLocalBaseDataSource {
  final HiveService hiveService;
  BooksLocalDataSource({required this.hiveService});

  final String _boxName = 'books';

  @override
  Future<List<ResultsEntity>> getBooks() async {
    try {
      List<ResultsEntity>? books = await hiveService.get<List<ResultsEntity>>(
        _boxName,
        'books',
      );
      if (books == null) {
        throw CacheException(message: 'No books found in local storage');
      }
      return books;
    } catch (e) {
      throw CacheException(message: 'Failed to get books: $e');
    }
  }

  @override
  Future<void> saveBooks(List<ResultsEntity> newBooks) async {
    try {
      List<ResultsEntity>? existingBooks =
          await hiveService.get<List<ResultsEntity>>(
        _boxName,
        'books',
      );

      if (existingBooks == null) {
        await hiveService.add<List<ResultsEntity>>(
          _boxName,
          'books',
          newBooks,
        );
        return;
      }

      final booksMap = <String, ResultsEntity>{};

      for (var book in existingBooks) {
        if (book.id != null) {
          booksMap[book.id.toString()] = book;
        }
      }

      for (var book in newBooks) {
        if (book.id != null) {
          booksMap[book.id.toString()] = book;
        }
      }

      final mergedBooks = booksMap.values.toList();
      await hiveService.add<List<ResultsEntity>>(
        _boxName,
        'books',
        mergedBooks,
      );
    } catch (e) {
      throw CacheException(message: 'Failed to save books: $e');
    }
  }

  @override
  Future<List<ResultsEntity>> searchBooks(String query) async {
    try {
      List<ResultsEntity>? books = await hiveService.get<List<ResultsEntity>>(
        _boxName,
        'books',
      );
      if (books == null) {
        throw CacheException(message: 'No books found in local storage');
      }

      if (query.isEmpty) {
        return books;
      }

      return books.where((book) {
        final searchLower = query.toLowerCase();
        return (book.title?.toLowerCase().contains(searchLower) ?? false) ||
            (book.authors?.any(
                  (element) =>
                      element.name?.toLowerCase().contains(searchLower) ??
                      false,
                ) ??
                false);
      }).toList();
    } catch (e) {
      throw CacheException(message: 'Failed to search books: $e');
    }
  }
}
