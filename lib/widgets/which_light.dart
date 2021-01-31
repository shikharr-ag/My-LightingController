import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WhichLight extends StatefulWidget {
  final int lights;
  WhichLight(this.lights);
  @override
  _WhichLightState createState() => _WhichLightState();
}

class _WhichLightState extends State<WhichLight> {
  List<String> lights = [
    'Main Light',
    'Ceiling Light',
    'Bed Light',
    'Desk Light',
    'Storeroom light'
  ];

  List<bool> _selections;
  int i = -1;
  @override
  void initState() {
    _selections = List.generate(widget.lights, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    i++;
    return SizedBox(
      height: 40,
      width: 230,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ToggleButtons(
            selectedColor: Colors.blue[900],
            renderBorder: false,
            children: List.generate(widget.lights, (i) {
              return SizedBox(
                height: 40,
                width: 100,
                child: Card(
                  color:
                      _selections[i] == true ? Colors.blue[900] : Colors.white,
                  //margin: EdgeInsets.only(left: 3.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5.0,
                      ),
                      if (i == 0)
                        SvgPicture.asset(
                          'assets/svg/surface1.svg',
                          color: _selections[i] == true
                              ? Colors.white
                              : Colors.blue[900],
                        ),
                      if (i == 2)
                        SvgPicture.asset(
                          'assets/svg/bed (1).svg',
                          color: _selections[i] == true
                              ? Colors.white
                              : Colors.blue[900],
                        ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        lights[i],
                        style: _selections[i] == true
                            ? Theme.of(context).textTheme.headline1
                            : Theme.of(context).textTheme.headline2,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              );
            }),
            onPressed: (i) {
              print(' before ${_selections[i]}');
              setState(() {
                _selections[i] = !_selections[i];
              });
              print(' after ${_selections[i]}');
            },
            isSelected: _selections,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ],
      ),
    );
  }
}
