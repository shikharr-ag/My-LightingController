import 'package:flutter/material.dart';
import 'package:lighting_control/widgets/color_button.dart';

class WhichColor extends StatefulWidget {
  final Function(Color) myColor;
  WhichColor(this.myColor);
  @override
  _WhichColorState createState() => _WhichColorState();
}

class _WhichColorState extends State<WhichColor>
    with SingleTickerProviderStateMixin {
  Animation<double> myAnimation;
  AnimationController myController;
  int i = -2;
  List<Color> myColors = [
    Colors.red[200],
    Colors.red[700],
    Colors.green[200],
    Colors.green[700],
    Colors.blue[200],
    Colors.blue[700],
    Colors.amber[200],
    Colors.amber[700],
    Colors.purple[200],
    Colors.purple[700],
    Colors.pink[200],
    Colors.pink[700],
    Colors.brown[200],
    Colors.brown[700],
    Colors.deepOrange[200],
    Colors.deepOrange[700],
  ];
  @override
  void initState() {
    myController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    myAnimation = Tween<double>(begin: 20, end: 55).animate(myController)
      ..addListener(() {
        setState(() {});
      });
    myController.forward();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    i = -2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15.0),
          child: Text(
            'Colors',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 750),
          padding: const EdgeInsets.all(5.0),
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, _) {
              i = i + 2;
              return ColorButton(myColors[i], myColors[i + 1], widget.myColor);
            },
            itemExtent: myAnimation.value,
            itemCount: myColors.length - 8,
          ),
        ),
      ],
    );
  }
}
