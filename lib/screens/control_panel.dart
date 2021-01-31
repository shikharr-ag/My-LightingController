import 'package:flutter/material.dart';
import 'package:lighting_control/screen_args.dart';

import '../widgets/detail_scaffold.dart';
import '../widgets/my_navigation_bar.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/control_grid.dart';

class ControlPanel extends StatefulWidget {
  static const routeName = '/control-panel';
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  double expandedHeight = 160;
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    print('Args $args');
    double oldExpHeight = args != null ? args.oldExpHeight : 0.0;
    return Scaffold(
      bottomNavigationBar: MyNavigationBar(),
      body: DetailScaffold(
        expandedHeight: expandedHeight,
        newExpandedHeight: oldExpHeight,
        isControlPanel: true,
        slivers: [
          MyAppBar(
              expandedHeight: expandedHeight,
              oldExpandedHeight: oldExpHeight != 0 ? oldExpHeight : 0.0),
          ControlGrid(expandedHeight),
        ],
      ),
    );
  }
}
