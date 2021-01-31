import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lighting_control/screen_args.dart';
import '../screens/light_control_screen.dart';

class ControlTile extends StatelessWidget {
  final tileNo;
  final double oldExpHeight;
  ControlTile(this.tileNo, this.oldExpHeight);
  @override
  Widget build(BuildContext context) {
    String title = '';
    String assetName;

    int lights = 0;
    switch (tileNo) {
      case (1):
        title = 'Bed room';
        assetName = 'assets/svg/bed.svg';
        lights = 4;
        break;
      case (2):
        title = 'Living room';
        assetName = 'assets/svg/room.svg';
        lights = 2;
        break;
      case (3):
        title = 'Kitchen';
        assetName = 'assets/svg/kitchen.svg';
        lights = 5;
        break;
      case (4):
        title = 'Bathroom';
        assetName = 'assets/svg/bathtube.svg';
        lights = 1;
        break;

      case (5):
        title = 'Outdoor';
        assetName = 'assets/svg/house.svg';
        lights = 5;
        break;
      case (6):
        title = 'Balcony';
        assetName = 'assets/svg/balcony.svg';
        lights = 2;
        break;
      default:
        print('default case');
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          LightControlScreen.routeName,
          arguments: ScreenArguments(title, lights, oldExpHeight),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(top: 27.0, left: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (assetName.isNotEmpty)
                  SvgPicture.asset(
                    assetName,
                    height: 50,
                    width: 50,
                    semanticsLabel: title,
                    fit: BoxFit.fill,
                  ),
                SizedBox(
                  height: 17,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  lights > 1 ? '$lights lights' : '$lights light',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(22.0),
            ),
          ),
        ),
      ),
    );
  }
}
