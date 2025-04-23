import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'core/localizations_cubit/localizations_cubit.dart';
import 'core/services/hive_service.dart';
import 'core/services/network_info.dart';
import 'core/services/network_service.dart/api_basehelper.dart';
import 'features/home/home_inject.dart';
import 'features/home/presentation/cubit/home_cubit.dart';

final GetIt sl = GetIt.instance;

abstract class ServiceLocator {
  static Future<void> init() async {
    sl.allowReassignment = true;
    initHomeInjection();
    _injectLocalizationsCubit();
    _injectDioHelper();
    _injectHiveService();
    _injectInternetConnection();
    _injectNetworkInfo();
  }
}

void _injectDioHelper() {
  final ApiBaseHelper helper = ApiBaseHelper();
  sl.registerLazySingleton<ApiBaseHelper>(() => helper);
}

ApiBaseHelper get dioHelper => sl<ApiBaseHelper>();
void _injectHiveService() {
  final HiveService hiveService = HiveService();
  sl.registerFactory<HiveService>(() => hiveService);
}

HiveService get hiveService => sl<HiveService>();
List<BlocProvider<Cubit<Object>>> appProviders() =>
    <BlocProvider<Cubit<Object>>>[
      BlocProvider<LocalizationsCubit>(
        create: (_) => sl<LocalizationsCubit>(),
      ),
      BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()..loadBooks()),
    ];

void _injectLocalizationsCubit() {
  sl.registerFactory<LocalizationsCubit>(() => LocalizationsCubit());
}

void _injectNetworkInfo() {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
}

void _injectInternetConnection() {
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
