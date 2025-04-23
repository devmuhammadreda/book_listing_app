import 'data/data_sources/books_local_data_source.dart';
import 'data/data_sources/books_remote_data_source.dart';
import 'data/repositories/books_repo.dart';
import 'domain/repositories/books_base_repo.dart';
import 'domain/usecases/get_all_books_use_case.dart';
import 'presentation/cubit/home_cubit.dart';

import '../../injection_container.dart';

void initHomeInjection() {
  sl.registerFactory(() => HomeCubit(getAllBooksUseCase: sl()));

  sl.registerLazySingleton<BooksBaseRepo>(() => BooksRepo(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<BooksLocalBaseDataSource>(
    () => BooksLocalDataSource(hiveService: sl()),
  );
  sl.registerLazySingleton<BooksRemoteBaseDataSource>(
    () => BooksRemoteDataSource(helper: sl()),
  );
  sl.registerLazySingleton(() => GetAllBooksUseCase(booksBaseRepo: sl()));
}

