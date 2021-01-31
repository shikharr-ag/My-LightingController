import 'package:flutter/material.dart';
import 'package:lighting_control/widgets/light_settings.dart';

class LightController extends StatefulWidget {
  final Function(Color, double) myValues;
  final int lights;
  LightController(this.myValues, {this.lights = 0});
  @override
  _LightControllerState createState() => _LightControllerState();
}

class _LightControllerState extends State<LightController> {
  Color selectedColor;
  double myIntensity;

  double sliderVal = 0.0;

  Function _selectColor(Color color) {
    setState(() {
      selectedColor = color;
    });
    widget.myValues(selectedColor, myIntensity);
  }

  Function _selectIntensity(double intensity) {
    setState(() {
      myIntensity = intensity;
    });

    widget.myValues(selectedColor, myIntensity);
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      delegate: SliverChildListDelegate(
        [
          LightSettings(_selectIntensity, _selectColor, lights: widget.lights),
        ],
      ),
    );
  }
}
