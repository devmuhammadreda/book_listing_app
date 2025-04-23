import 'package:book_listing_app/core/localizations_cubit/localizations_cubit.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:book_listing_app/core/extensions/build_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/size_config.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/router.dart';
import 'core/widgets/error_screen.dart';
import 'features/home/presentation/pages/home_screen.dart';
import 'injection_container.dart';
import 'l10n/messages.dart';
import 'l10n/messages.dart' as common_messages;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MultiBlocProvider(
      providers: appProviders(),
      child: BlocBuilder<LocalizationsCubit, LocalizationsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            splitScreenMode: true,
            builder: (context, child) {
              SizeConfig().init(context);
              return MaterialApp(
                navigatorObservers: [BotToastNavigatorObserver()],
                onGenerateTitle: (context) => context.translate.appName,
                debugShowCheckedModeBanner: false,
                theme: ThemeManager.appTheme,
                navigatorKey: navigatorKey,
                onGenerateRoute: onGenerateRoute,
                themeMode: ThemeMode.light,
                locale: context.read<LocalizationsCubit>().locale,
                localizationsDelegates: const [
                  ...S.localizationsDelegates,
                  common_messages.S.delegate,
                ],
                supportedLocales: S.supportedLocales,
                home: HomeScreen(),
                builder: (context, child) {
                  handelErrorScreen(context);
                  child = botToastBuilder(context, child!);
                  return child;
                },
              );
            },
          );
        },
      ),
    );
  }
}
