import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:one_bataan_league_pass/resources/resources.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    Key key,
    this.width = 128,
    this.height = 24,
    this.child,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: child != null
          ? child
          : Container(
              width: width,
              height: height,
              color: Colors.grey[200],
            ),
      baseColor: Theme.of(context).customTheme().shimmerBaseColor,
      highlightColor: Theme.of(context).customTheme().shimmerHighLightColor,
    );
  }
}
