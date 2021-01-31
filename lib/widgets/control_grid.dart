import 'package:flutter/material.dart';
import 'control_tile.dart';

class ControlGrid extends StatelessWidget {
  final double oldExpHeight;
  ControlGrid(this.oldExpHeight);
  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        childAspectRatio: 5 / 5.2,
      ),
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => ControlTile(i + 1, oldExpHeight),
        childCount: 6,
      ),
    );
  }
}
