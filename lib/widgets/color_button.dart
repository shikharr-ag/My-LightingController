import 'dart:ui';

import 'package:flutter/material.dart';

class ColorButton extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Function(Color) myColor;
  ColorButton(this.color1, this.color2, this.myColor);
  @override
  _ColorButtonState createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [widget.color1, widget.color2],
          ),
        ),
      ),
      onTap: () => widget.myColor(widget.color2),
    );
  }
}
