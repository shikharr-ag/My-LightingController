import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lighting_control/widgets/scenes_selector.dart';
import 'package:lighting_control/widgets/which_color.dart';

class LightSettings extends StatefulWidget {
  final Function(double) _selectIntensity;
  final Function(Color) _selectColor;
  final int lights;
  LightSettings(this._selectIntensity, this._selectColor, {this.lights = 0});
  @override
  _LightSettingsState createState() => _LightSettingsState();
}

class _LightSettingsState extends State<LightSettings> {
  double _sliderVal = 0.0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 55,
            padding: EdgeInsets.all(12.0),
            width: double.infinity,
            child: Text(
              'Intensity',
              style: Theme.of(context).textTheme.headline4,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            height: 50,
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/svg/solution2.svg',
                width: 40,
                height: 40,
              ),
              title: Slider(
                divisions: 5,
                label: '$_sliderVal',
                max: 5,
                min: 0,
                value: _sliderVal,
                onChanged: (val) {
                  setState(() {
                    _sliderVal = val.ceilToDouble();
                  });
                },
                onChangeEnd: (val) {
                  return widget._selectIntensity(val);
                },
              ),
              trailing: SvgPicture.asset(
                'assets/svg/solution1.svg',
                color: Colors.yellow[500],
                height: 40,
                width: 40,
              ),
              contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          WhichColor(widget._selectColor),
          SizedBox(
            height: 15,
          ),
          ScenesSelector(),
        ],
      ),
    );
  }
}
