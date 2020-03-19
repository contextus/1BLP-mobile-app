import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/widgets/one_bataan_sports_text.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OneBataanSportsText(fontSize: 18),
      ),
    );
  }
}
