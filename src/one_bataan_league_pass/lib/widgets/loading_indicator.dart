import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    this.size = 16,
    this.color,
  })  : assert(size != null),
        super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double width = size ?? 16;
    final double height = size ?? 16;
    return Container(
      width: width,
      height: height,
      child: CircularProgressIndicator(
        strokeWidth: width / 8,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Theme.of(context).accentColor),
      ),
    );
  }
}
