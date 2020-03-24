import 'package:flutter/material.dart';

/// A custom widget similar to [Column], but allows
/// setting the [spacing] between each [children].
class ExtendedColumn extends StatelessWidget {
  ExtendedColumn({
    Key key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.spacing = 4.0,
  })  : assert(spacing != null),
        assert(spacing >= 0),
        super(key: key);

  final double spacing;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getChildren(),
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
    );
  }

  List<Widget> getChildren() {
    if (spacing == 0) return children;

    final newChildren = <Widget>[];

    children.forEach((w) {
      newChildren.add(w);
      if (children.last != w) newChildren.add(SizedBox(height: spacing));
    });

    return newChildren;
  }
}
