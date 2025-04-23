import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../entities/book_entity.dart';
import '../parameters/get_all_books_params.dart';
import '../repositories/books_base_repo.dart';

class GetAllBooksUseCase extends BaseUseCase<BooksEntity, GetAllBooksParams> {
  final BooksBaseRepo booksBaseRepo;

  GetAllBooksUseCase({required this.booksBaseRepo});

  @override
  Future<Either<Failure, BooksEntity>> call(GetAllBooksParams parameters) async {
    return await booksBaseRepo.getAllBooks(parameters);
  }
}
