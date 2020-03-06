import 'package:share/share.dart';

class SharingService {
  Future<void> share(String text, {String subject}) => Share.share(text, subject: subject);
}
