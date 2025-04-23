import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/book_entity.dart';
import '../parameters/get_all_books_params.dart';

abstract class BooksBaseRepo{
  Future<Either<Failure, BooksEntity>> getAllBooks(GetAllBooksParams params);
}
