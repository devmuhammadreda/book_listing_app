import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/bloc_observer.dart';
import 'core/services/get_storage_helper.dart';
import 'core/services/hive_service.dart';
import 'injection_container.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await ServiceLocator.init();
  await sl<HiveService>().init();
  runApp(MyApp());
}
