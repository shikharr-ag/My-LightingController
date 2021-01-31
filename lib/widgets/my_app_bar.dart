import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lighting_control/screens/settings_screen.dart';
import 'package:lighting_control/widgets/which_light.dart';
//import 'package:lighting_control/widgets/control_grid.dart';

class MyAppBar extends StatefulWidget {
  final double expandedHeight;
  final double oldExpandedHeight;
  final bool isControlPanel;
  final bool isSettings;
  final String roomName;
  final int lights;
  final Color lightColor;
  final double intensity;
  MyAppBar({
    this.expandedHeight = 160.0,
    this.oldExpandedHeight = 0.0,
    this.isControlPanel = true,
    this.isSettings = false,
    this.roomName = 'Control Panel',
    this.lights = 0,
    this.lightColor = Colors.yellow,
    this.intensity = 10.0,
  });

  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> with TickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> opacityAnimation;
  Animation<double> rotationAnimation;
  Animation<Offset> offsetAnimation;

  AnimationController controller;
  AnimationController opacityController;
  AnimationController rotationController;
  AnimationController offsetController;

  Widget _controlPanelTitle(BuildContext ctx, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 110,
          child: Text(title == '' ? widget.roomName : title,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: Theme.of(ctx).textTheme.headline6),
        ),
        SizedBox(
          width: 70,
        ),
        GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(SettingsScreen.routeName),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/svg/IMG_8978-min.JPG'),
          ),
        ),
      ],
    );
  }

  Widget _lightControlTitle(String roomName, BuildContext ctx) {
    return Stack(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 14.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 87,
                    child: Text(
                      roomName,
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.headline6,
                      softWrap: true,
                      textScaleFactor: 0.9,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  AnimatedOpacity(
                    duration: Duration(seconds: 1),
                    opacity: opacityAnimation.value,
                    child: Container(
                      child: Text(
                        widget.lights > 1
                            ? '${widget.lights} Lights'
                            : '${widget.lights} Light',
                        style: Theme.of(ctx).textTheme.headline5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 48.0, bottom: 53.0, right: 8.0),
              child: Stack(
                children: [
                  Positioned(
                    right: 38,
                    top: 50,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: widget.lightColor,
                            blurRadius: widget.intensity,
                            spreadRadius: 2.2,
                            offset: Offset.fromDirection(1.571, 23.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: SvgPicture.asset(
                      'assets/svg/light bulb.svg',
                      height: 110,
                      color: widget.lightColor,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/Group 38.svg',
                    height: 85.6,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 120,
          left: 20,
          child: SlideTransition(
            position: offsetAnimation,
            child: WhichLight(widget.lights),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    opacityController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    rotationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    offsetController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    animation = Tween<double>(
            begin: widget.oldExpandedHeight, end: widget.expandedHeight)
        .animate(controller)
          ..addListener(() {
            setState(() {});
          });
    opacityAnimation =
        Tween<double>(begin: 0, end: 1).animate(opacityController)
          ..addListener(() {
            setState(() {});
          });
    rotationAnimation =
        Tween<double>(begin: 0, end: 3.14).animate(rotationController)
          ..addListener(() {
            setState(() {});
          });
    offsetAnimation =
        Tween<Offset>(begin: Offset(0.50, 0.0), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(parent: offsetController, curve: Curves.easeIn))
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
    offsetController.forward();
    opacityController.forward();
    rotationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (widget.isSettings) {
      title = 'My Profile';
    }
    return SliverAppBar(
      backgroundColor: Colors.blue[900],
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.only(bottom: 50.0),
        title: widget.isControlPanel
            ? _controlPanelTitle(context, title)
            : _lightControlTitle(widget.roomName, context),
        background: Transform.rotate(
          angle: rotationAnimation.value,
          child: SvgPicture.asset(
            'assets/svg/Circles.svg',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
      ),
      titleSpacing: 0.0,
      expandedHeight: widget.oldExpandedHeight == 0.0
          ? widget.expandedHeight
          : animation.value,
    );
  }
}
