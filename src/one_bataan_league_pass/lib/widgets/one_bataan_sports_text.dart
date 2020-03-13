import 'package:flutter/material.dart';

class OneBataanSportsText extends StatelessWidget {
  OneBataanSportsText({Key key, this.fontSize = 14.0}) : super(key: key);

  final double fontSize;
  final _primaryColorGreen = Color.fromARGB(255, 130, 203, 4);
  final _primaryColorBlue = Color.fromARGB(255, 2, 122, 224);
  final _primaryColorRed = Color.fromARGB(255, 223, 54, 2);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: '1', style: TextStyle(color: _primaryColorBlue)),
          TextSpan(text: 'Bataan ', style: TextStyle(color: _primaryColorGreen)),
          TextSpan(text: 'Sports', style: TextStyle(color: _primaryColorRed)),
        ],
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
