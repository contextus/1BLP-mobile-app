import 'package:share/share.dart';

abstract class SharingService {
  Future<void> share(String text, [String subject]);
}

class FlutterSharingService implements SharingService {
  @override
  Future<void> share(String text, [String subject]) => Share.share(text, subject: subject);
}
