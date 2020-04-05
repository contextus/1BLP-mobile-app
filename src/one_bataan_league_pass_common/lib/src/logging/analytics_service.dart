import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';
import 'package:one_bataan_league_pass_common/src/constants/app_center_constants.dart';
import 'package:one_bataan_league_pass_common/src/app_configuration.dart';

/// Application analytics service provider.
abstract class AnalyticsService {
  /// Starts the service.
  Future<void> start();
  
  /// Tracks an event by logging it to the analytics server.
  /// 
  /// You can pass [properties] to provide a more detailed info about the event.
  Future<void> trackEvent(String eventName, [Map<String, String> properties]);
}

class AppCenterAnalytics implements AnalyticsService {
  @override
  Future<void> start() {
    return _runIfAnalyticsEnabled(
      () => AppCenter.startAsync(
        appSecretAndroid: AppCenterConstants.androidKey,
        appSecretIOS: AppCenterConstants.iosKey,
      ),
    );
  }

  @override
  Future<void> trackEvent(String eventName, [Map<String, String> properties]) {
    return _runIfAnalyticsEnabled(() => AppCenter.trackEventAsync(eventName, properties));
  }

  static Future<void> _runIfAnalyticsEnabled(Future<void> Function() futureFactory) {
    if (AppConfiguration.isAnalyticsEnabled) return futureFactory();

    return Future.value();
  }
}
