import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lighting_control/widgets/my_navigation_bar.dart';
import '../screen_args.dart';
import '../widgets/detail_scaffold.dart';
import '../widgets/light_controller.dart';
import '../widgets/my_app_bar.dart';

class LightControlScreen extends StatefulWidget {
  static const routeName = '/light-control-screen';
  final double oldExpHeight;
  LightControlScreen(this.oldExpHeight);

  @override
  _LightControlScreenState createState() => _LightControlScreenState();
}

class _LightControlScreenState extends State<LightControlScreen> {
  final _scaffold = GlobalKey<ScaffoldState>();
  Color selectedColor = Colors.yellow;
  double myIntensity = 0.0;
  bool _isFirst = true;

  Function _myValues(Color color, double intensity) {
    setState(() {
      color == null ? color = selectedColor : selectedColor = color;
      intensity == null ? intensity = myIntensity : myIntensity = intensity;
    });
  }

  @override
  Widget build(BuildContext context) {
    double expandedHeight = 270;

    String msg = '';
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffold,
      backgroundColor: Theme.of(context).canvasColor,
      bottomNavigationBar: MyNavigationBar(
        oldExpandedHeight: expandedHeight,
      ),
      body: Stack(
        children: [
          DetailScaffold(
            newExpandedHeight: expandedHeight,
            slivers: [
              MyAppBar(
                expandedHeight: expandedHeight,
                oldExpandedHeight: args.oldExpHeight,
                isControlPanel: false,
                roomName: args.roomName,
                lights: args.lights,
                lightColor: selectedColor,
                intensity: (18 - (myIntensity + 4)),
              ),
              LightController(_myValues, lights: args.lights),
            ],
          ),
          Positioned(
            right: 10.0,
            top: expandedHeight - 45,
            child: MaterialButton(
              elevation: 6.0,
              color: Colors.white,
              shape: CircleBorder(
                side: BorderSide(width: 0.6),
              ),
              onPressed: () {
                if (_isFirst) {
                  setState(() {
                    _isFirst = !_isFirst;
                    selectedColor = Colors.black;
                    msg = 'Lights off';
                  });
                } else {
                  setState(() {
                    _isFirst = !_isFirst;
                    selectedColor = Colors.yellow;
                    msg = 'Lights on';
                  });
                }
                _scaffold.currentState.hideCurrentSnackBar();
                _scaffold.currentState.showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Text(
                      msg,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/svg/Icon awesome-power-off.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
