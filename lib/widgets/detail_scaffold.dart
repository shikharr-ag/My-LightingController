import 'package:flutter/material.dart';

class DetailScaffold extends StatefulWidget {
  final ScrollController controller;

  final ScrollPhysics physics;
  final List<Widget> slivers;
  final bool isControlPanel;
  final double expandedHeight;
  final double newExpandedHeight;

  /// Changes edge behavior to account for [SliverAppBar.pinned].
  ///
  /// Hides the edge when the [ScrollController.offset] reaches the collapsed
  /// height of the [SliverAppBar] to prevent it from overlapping the app bar.
  final bool hasPinnedAppBar;

  DetailScaffold({
    this.expandedHeight = 160.0,
    this.newExpandedHeight = 0.0,
    this.controller,
    this.physics,
    this.slivers,
    this.hasPinnedAppBar = false,
    this.isControlPanel = false,
  }) {
    assert(expandedHeight != null);
    assert(hasPinnedAppBar != null);
  }

  @override
  _DetailScaffoldState createState() => _DetailScaffoldState();
}

class _DetailScaffoldState extends State<DetailScaffold>
    with SingleTickerProviderStateMixin {
  ScrollController ctrl;
  AnimationController myController;
  Animation<double> myAnimation;

  @override
  void initState() {
    super.initState();
    myAnimation = null;
    myController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    if (widget.newExpandedHeight != 0 &&
        widget.newExpandedHeight > widget.expandedHeight &&
        widget.isControlPanel == false) {
      myAnimation = Tween<double>(
              begin: widget.expandedHeight, end: widget.newExpandedHeight)
          .animate(myController)
            ..addListener(() {
              setState(() {});
            });
    } else if (widget.newExpandedHeight != 0 &&
        widget.newExpandedHeight > widget.expandedHeight &&
        widget.isControlPanel == true) {
      myAnimation = Tween<double>(
              begin: widget.newExpandedHeight, end: widget.expandedHeight)
          .animate(myController)
            ..addListener(() {
              setState(() {});
            });
    }
    print('MyAnimation $myAnimation , exp height ${widget.expandedHeight}');
    myController.forward();
    ctrl = widget.controller ?? ScrollController();
    ctrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      ctrl.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CustomScrollView(
          controller: ctrl,
          physics: widget.physics,
          slivers: widget.slivers,
        ),
        _buildEdge(),
      ],
    );
  }

  _buildEdge() {
    var edgeHeight = 40.0;
    var paddingTop = MediaQuery.of(context).padding.top;

    var defaultOffset = (paddingTop +
            (myAnimation == null ? widget.expandedHeight : myAnimation.value)) -
        edgeHeight;

    var top = defaultOffset;
    var edgeSize = edgeHeight;

    if (ctrl.hasClients) {
      double offset = ctrl.offset;
      top -= offset > 0 ? offset : 0;

      if (widget.hasPinnedAppBar) {
        // Hide edge to prevent overlapping the toolbar during scroll.
        var breakpoint =
            (myAnimation == null ? widget.expandedHeight : myAnimation.value) -
                kToolbarHeight -
                edgeHeight;

        if (offset >= breakpoint) {
          edgeSize = edgeHeight - (offset - breakpoint);
          if (edgeSize < 0) {
            edgeSize = 0;
          }

          top += (edgeHeight - edgeSize);
        }
      }
    }

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(left: 13.0, top: 12.0),
        height: edgeSize + 1,
        child: widget.isControlPanel
            ? Text(
                'All Rooms',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              )
            : Text(''),
        decoration: BoxDecoration(
          //color: Colors.black,
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
