import 'dart:io';

import 'package:buddy/domain/services/services.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version_tracker/version_tracker.dart';

class DeviceInfoServiceImpl implements DeviceInfoService {
  late Map<String, String> _deviceInfo;
  late String _appName;
  late String _version;
  late bool _versionChanged = false;

  @override
  Map<String, String> get deviceInfo => _deviceInfo;

  @override
  String get appName => _appName;

  @override
  String get version => _version;

  @override
  bool get versionChanged => _versionChanged;

  @override
  Future<void> init() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _appName = packageInfo.appName;
      _version = Platform.isWindows ? packageInfo.version : '${packageInfo.version}+${packageInfo.buildNumber}';

      await _initVersionTracker();

      if (Platform.isAndroid) {
        await _initForAndroid();
      }
    } catch (ex) {
      _deviceInfo = {
        'Model': 'N/A',
        'OsVersion': 'N/A',
        'AppVersion': 'N/A',
      };
      _version = _appName = 'N/A';
    }
  }

  Future<void> _initForAndroid() async {
    final deviceInfo = DeviceInfoPlugin();
    final info = await deviceInfo.androidInfo;
    _deviceInfo = {
      'Model': info.model,
      'OsVersion': '${info.version.sdkInt}',
      'AppVersion': _version,
    };
  }

  Future<void> _initVersionTracker() async {
    final vt = VersionTracker();
    await vt.track();
    _versionChanged = vt.isFirstLaunchForCurrentBuild ?? vt.isFirstLaunchForCurrentVersion ?? vt.isFirstLaunchEver ?? false;
  }
}
