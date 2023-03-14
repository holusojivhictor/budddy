import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/enums/enums.dart';
import 'package:buddy/presentation/shared/extensions/app_theme_type_extensions.dart';
import 'package:buddy/presentation/shared/loading.dart';
import 'package:buddy/session_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (ctx, state) => state.map(
        loading: (_) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppThemeType.light.getLightTheme(),
          home: const Loading(),
        ),
        loaded: (s) {
          final autoThemeModeOn = s.autoThemeMode == AutoThemeModeType.on;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: s.appTitle,
            theme: autoThemeModeOn ? AppThemeType.light.getLightTheme() : s.theme.getThemeData(s.theme),
            darkTheme: autoThemeModeOn ? AppThemeType.light.getDarkTheme() : null,
            home: BlocBuilder<SessionBloc, SessionState>(
              builder: (ctx, state) => const SessionWrapper(),
            ),
          );
        },
      ),
    );
  }
}
