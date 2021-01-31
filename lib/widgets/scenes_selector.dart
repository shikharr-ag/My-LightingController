import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScenesSelector extends StatefulWidget {
  @override
  _ScenesSelectorState createState() => _ScenesSelectorState();
}

class _ScenesSelectorState extends State<ScenesSelector>
    with SingleTickerProviderStateMixin {
  AnimationController offsetController;
  Animation<Offset> offset;

  List<Color> myColors = [
    Colors.red[200],
    Colors.red[700],
    Colors.lightGreen[100],
    Colors.lightGreen[500],
    Colors.lightBlue[100],
    Colors.lightBlue[300],
    Colors.amber[200],
    Colors.amber[700],
  ];

  Widget _myScenes(
      int color1,
      int color2,
      int color3,
      int color4,
      String assetName,
      String title1,
      String title2,
      Color logo,
      TextStyle ts) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(top: 10.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          width: 40,
        ),
        Container(
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              SvgPicture.asset(
                assetName,
                color: logo,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                title1,
                style: ts,
              ),
            ],
          ),
          width: 130,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                myColors[color1],
                myColors[color2],
              ],
            ),
          ),
        ),
        SizedBox(width: 40),
        Container(
          width: 130,
          height: 45,
          child: Row(
            children: [
              SizedBox(
                width: 6,
              ),
              SvgPicture.asset(
                assetName,
                color: logo,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                title2,
                style: ts,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              colors: [
                myColors[color3],
                myColors[color4],
              ],
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void initState() {
    offsetController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    offset = Tween<Offset>(begin: Offset(0.50, 0.0), end: Offset(0.0, 0.0))
        .animate(
            CurvedAnimation(parent: offsetController, curve: Curves.easeIn))
          ..addListener(() {
            setState(() {});
          });
    offsetController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '    Scenes',
            style: Theme.of(context).textTheme.headline4,
          ),
          _myScenes(1, 0, 3, 2, 'assets/svg/surface1.svg', 'Birthday', 'Party',
              Colors.white, Theme.of(context).textTheme.headline6),
          _myScenes(4, 5, 6, 7, 'assets/svg/surface1.svg', 'Relax', 'Fun',
              Colors.white, Theme.of(context).textTheme.headline6)
        ],
      ),
    );
  }
}
