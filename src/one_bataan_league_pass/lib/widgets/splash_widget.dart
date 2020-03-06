import 'package:flutter/material.dart';
import 'package:one_bataan_league_pass/widgets/one_bataan_league_text.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OneBataanLeagueText(fontSize: 18),
      ),
    );
  }
}
