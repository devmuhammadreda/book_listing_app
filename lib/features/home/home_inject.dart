import 'presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

void initHomeInjection() {
  sl.registerFactory(() => HomeCubit());
}

List<BlocProvider<Cubit<Object>>> homeCubits() => <BlocProvider<Cubit<Object>>>[
      BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()),
    ];
