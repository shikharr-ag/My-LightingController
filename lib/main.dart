import 'package:flutter/material.dart';
import 'package:lighting_control/screens/control_panel.dart';
import 'package:lighting_control/screens/light_control_screen.dart';
import 'package:lighting_control/screens/settings_screen.dart';

void main() {
  runApp(LightingControl());
}

class LightingControl extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lighting Control',
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        fontFamily: 'Lato',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.grey[300],
          activeTrackColor: Colors.yellow,
          inactiveTickMarkColor: Colors.black,
          showValueIndicator: ShowValueIndicator.always,
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 8.0,
          ),
          minThumbSeparation: 7.0,
          thumbColor: Colors.grey[200],
          trackHeight: 3.0,
          trackShape: RoundedRectSliderTrackShape(),
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
          headline5: TextStyle(
            color: Colors.yellow[600],
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          headline4: TextStyle(
            color: Colors.blue[700],
            fontSize: 23.0,
            fontWeight: FontWeight.w600,
          ),
          headline3: TextStyle(
            color: Colors.black87,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            color: Colors.black87,
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      routes: {
        LightControlScreen.routeName: (ctx) => LightControlScreen(0.0),
        SettingsScreen.routeName: (ctx) => SettingsScreen()
      },
      home: ControlPanel(),
    );
  }
}
