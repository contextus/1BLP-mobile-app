import 'package:one_bataan_league_pass_common/constants.dart';
import 'package:one_bataan_league_pass_common/runtime.dart';
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

class AnalyticsService {
  Future<void> start() {
    return _runIfAnalyticsEnabled(
      () => AppCenter.startAsync(
        appSecretAndroid: AppCenterConstants.androidKey,
        appSecretIOS: AppCenterConstants.iosKey,
      ),
    );
  }

  Future<void> trackEvent(String eventName, [Map<String, String> properties]) {
    return _runIfAnalyticsEnabled(() => AppCenter.trackEventAsync(eventName, properties));
  }

  static Future<void> _runIfAnalyticsEnabled(Future<void> Function() futureFactory) {
    if (AppConfiguration.isAnalyticsEnabled) return futureFactory();

    return Future.value();
  }
}
