import '../../../../core/global/api_keys.dart';
import '../../../../core/services/network_service.dart/api_basehelper.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/parameters/get_all_books_params.dart';
import '../models/books_model.dart';

abstract class BooksRemoteBaseDataSource {
  Future<BooksEntity> getBooks(GetAllBooksParams params);
}

class BooksRemoteDataSource extends BooksRemoteBaseDataSource {
  final ApiBaseHelper helper;
  BooksRemoteDataSource({required this.helper});
  @override
  Future<BooksEntity> getBooks(GetAllBooksParams params) async {
    final response = await helper.request(
      method: HttpMethod.get,
      url: APIKeys.getBooks,
      queryParameters: params.toJson(),
    );
    try {
      return BooksModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
