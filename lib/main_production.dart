import 'package:buddy/application/bloc.dart';
import 'package:buddy/domain/services/services.dart';
import 'package:buddy/firebase_options.dart';
import 'package:buddy/injection.dart';
import 'package:buddy/presentation/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Injection.init();
  runApp(const BuddyApp());
}

class BuddyApp extends StatelessWidget {
  const BuddyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => MainTabBloc()),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            final appService = getIt<BuddyAppService>();
            return SessionBloc(
              authService,
              appService,
              ctx.read<MainTabBloc>(),
            )..add(const SessionEvent.appStarted(init: true));
          },
        ),
        BlocProvider(
          create: (ctx) {
            final appService = getIt<BuddyAppService>();
            return HomeBloc(appService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final appService = getIt<BuddyAppService>();
            return BuddiesBloc(appService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return MainBloc(
              loggingService,
              settingsService,
              deviceInfoService,
            )..add(const MainEvent.init());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return SettingsBloc(
              settingsService,
              deviceInfoService,
              ctx.read<MainBloc>(),
            )..add(const SettingsEvent.init());
          },
        ),
      ],
      child: BlocBuilder<MainBloc, MainState>(
        builder: (ctx, state) => const AppWidget(),
      ),
    );
  }
}
