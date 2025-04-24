import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/results_entity.dart';
import '../../domain/parameters/get_all_books_params.dart';
import '../../domain/usecases/get_all_books_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.getAllBooksUseCase}) : super(HomeInitial());
  final GetAllBooksUseCase getAllBooksUseCase;

  int _currentPage = 1;
  bool _hasMorePages = true;
  bool _isLoading = false;
  String? _currentSearch;

  final List<ResultsEntity> _allBooks = [];

  Future<void> loadBooks({
    int? page,
    String? search,
    bool resetList = false,
  }) async {
    if (_isLoading || (!_hasMorePages && !resetList)) {
      return;
    }

    bool isSearchChanged = search != _currentSearch && search != null;

    if (resetList || isSearchChanged) {
      _currentPage = 1;
      _hasMorePages = true;
      _allBooks.clear();
      emit(BooksLoading());
    } else {
      emit(BooksLoadingMore(books: _allBooks));
    }

    if (search != null) {
      _currentSearch = search;
    }

    _isLoading = true;

    final params = GetAllBooksParams(
      page: page ?? _currentPage,
      search: _currentSearch,
    );

    final result = await getAllBooksUseCase.call(params);

    result.fold(
      (failure) {
        if (_allBooks.isEmpty) {
          emit(BooksError(message: failure.message));
        } else {
          emit(BooksLoaded(
            books: _allBooks,
            hasMorePages: false,
            error: failure.message,
          ));
        }
        _isLoading = false;
      },
      (books) {
        if (books.results != null) {
          for (var book in books.results!) {
            if (!_allBooks.any((element) => element.id == book.id)) {
              _allBooks.add(book);
            }
          }
        }

        _hasMorePages = books.next != null;

        if (books.results != null && books.results!.isNotEmpty) {
          _currentPage++;
        }

        emit(BooksLoaded(
          books: _allBooks,
          hasMorePages: _hasMorePages,
        ));
        _isLoading = false;
      },
    );
  }

  Future<void> loadMoreBooks() async {
    if (!_isLoading && _hasMorePages) {
      await loadBooks();
    }
  }

  Future<void> refreshBooks() async {
    await loadBooks(resetList: true);
  }

  Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      await clearFilters();
    } else {
      await loadBooks(search: query, resetList: true);
    }
  }

  Future<void> clearFilters() async {
    _currentSearch = null;
    await loadBooks(resetList: true);
  }
}
