class AppConfiguration {
  static bool _configured = false;
  static String _serverAddress;
  static bool _isAnalyticsEnabled;

  static String get serverAddress => _serverAddress;
  static bool get isAnalyticsEnabled => _isAnalyticsEnabled;

  static void configure({String serverAddress, bool isAnalyticsEnabled = false}) {
    if (_configured) return;

    _serverAddress = serverAddress;
    _isAnalyticsEnabled = isAnalyticsEnabled;
    _configured = true;
  }
}
