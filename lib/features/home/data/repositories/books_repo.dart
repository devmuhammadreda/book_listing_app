import 'dart:developer';

import 'package:book_listing_app/core/error/failures.dart';
import 'package:book_listing_app/features/home/domain/entities/book_entity.dart';
import 'package:book_listing_app/features/home/domain/parameters/get_all_books_params.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/network_info.dart';
import '../../domain/repositories/books_base_repo.dart';
import '../data_sources/books_local_data_source.dart';
import '../data_sources/books_remote_data_source.dart';

class BooksRepo extends BooksBaseRepo {
  final BooksRemoteBaseDataSource remoteDataSource;
  final BooksLocalBaseDataSource localDataSource;
  final NetworkInfo networkInfo;

  BooksRepo({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BooksEntity>> getAllBooks(
      GetAllBooksParams params) async {
    try {
      final isConnected = await networkInfo.isConnected;

      if (isConnected) {
        final remoteBooks = await remoteDataSource.getBooks(params);
        if (params.search == null || params.search!.isEmpty) {
          await localDataSource.saveBooks(remoteBooks.results ?? []);
        }
        return Right(remoteBooks);
      } else {
        try {
          if (params.search != null && params.search!.isNotEmpty) {
            final localBooks =
                await localDataSource.searchBooks(params.search!);
            return Right(BooksEntity(
              next: null,
              previous: null,
              count: localBooks.length,
              results: localBooks,
            ));
          }
          final localBooks = await localDataSource.getBooks();
          return Right(BooksEntity(
            next: null,
            previous: null,
            count: localBooks.length,
            results: localBooks,
          ));
        } catch (e) {
          return Left(CacheFailure(message: 'No cached books available'));
        }
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      log('Unexpected error in getAllBooks: $e');
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}
