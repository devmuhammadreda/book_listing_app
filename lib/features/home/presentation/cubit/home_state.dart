part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class BooksLoading extends HomeState {}

class BooksLoadingMore extends HomeState {
  final List<ResultsEntity> books;

  BooksLoadingMore({required this.books});
}

class BooksLoaded extends HomeState {
  final List<ResultsEntity> books;
  final bool hasMorePages;
  final String? error;

  BooksLoaded({
    required this.books,
    required this.hasMorePages,
    this.error,
  });
}

class BooksError extends HomeState {
  final String message;

  BooksError({required this.message});
}
