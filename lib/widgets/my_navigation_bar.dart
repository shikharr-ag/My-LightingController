import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:lighting_control/screen_args.dart';
import 'package:lighting_control/screens/settings_screen.dart';

class MyNavigationBar extends StatelessWidget {
  final double oldExpandedHeight;
  MyNavigationBar({this.oldExpandedHeight = 0.0});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 60,
        ),
        MaterialButton(
          child: SvgPicture.asset('assets/svg/bulb.svg'),
          onPressed: () {
            print('Do something.');
          },
        ),
        MaterialButton(
          child: SvgPicture.asset('assets/svg/Icon feather-home.svg'),
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/', (Route<dynamic> route) => false,
                arguments: ScreenArguments('', 0, oldExpandedHeight));
          },
        ),
        MaterialButton(
          child: SvgPicture.asset('assets/svg/Icon feather-settings.svg'),
          onPressed: () {
            Navigator.of(context).pushNamed(SettingsScreen.routeName);
            print('Open settings page');
          },
        ),
      ],
    );
  }
}
