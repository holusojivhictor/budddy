import 'package:buddy/application/bloc.dart';
import 'package:get_it/get_it.dart';
import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static PageViewBloc get pageViewBloc {
    return PageViewBloc();
  }

  static ForgotPasswordBloc get forgotPasswordBloc {
    final authService = getIt<AuthService>();
    return ForgotPasswordBloc(authService);
  }

  static SignUpBloc getSignUpBloc(SessionBloc bloc) {
    final authService = getIt<AuthService>();
    return SignUpBloc(authService, bloc);
  }

  static SignInBloc getSignInBloc(SessionBloc bloc) {
    final authService = getIt<AuthService>();
    return SignInBloc(authService, bloc);
  }

  static BuddyBloc getBuddyBloc(HomeBloc homeBloc) {
    final appService = getIt<BuddyAppService>();
    return BuddyBloc(appService, homeBloc);
  }

  static Future<void> init() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);

    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);

    getIt.registerSingleton<BuddyAppService>(
      BuddyAppServiceImpl(authService),
    );
  }
}
