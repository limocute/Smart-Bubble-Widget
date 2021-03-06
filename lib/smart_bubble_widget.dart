import 'package:flutter/material.dart';
import 'package:smart_bubble/bubble.dart';

enum ArrowDirection { right, left }

enum ArrowDirection { right, left, none }

class SmartBubble extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;
  final Color color;
  final Color borderColor;
  final ArrowDirection arrowDirection;
  final child;
  final Text title;
  final arrowHeight;
  final arrowAngle;
  final radius;
  final innerPadding;
  final strokeWidth;
  final style;

  final EdgeInsets padding;

  SmartBubble({Key key,
    this.maxWidth = 200.0,
    this.maxHeight = 2048.0,
    this.color = Colors.blue,
    this.borderColor,
    this.arrowDirection = ArrowDirection.right,
    this.child,
    this.title,
    this.arrowHeight,
    this.arrowAngle,
    this.radius,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.innerPadding,
    this.strokeWidth,
    this.style})
      : super(key: key);

  @override
  State createState() =>
      _SmartBubbleState(
          this.maxWidth,
          this.maxHeight,
          this.color,
          this.borderColor,
          this.arrowDirection,
          this.child,
          this.title,
          this.arrowHeight,
          this.padding,
          this.arrowAngle,
          this.radius,
          this.innerPadding,
          this.strokeWidth,
          this.style);
}

class _SmartBubbleState extends State {
  double width;
  double height;
  Color color;
  Color borderColor;
  final ArrowDirection arrowDirection;
  final child;
  Text title;
  var arrowHeight;
  EdgeInsets padding;
  var arrowAngle;
  var radius;
  var innerPadding;
  final strokeWidth;
  final style;

  bool visible;

  GlobalKey _key;
  WidgetsBinding _widgetsBinding;

  _SmartBubbleState(this.width,
      this.height,
      this.color,
      this.borderColor,
      this.arrowDirection,
      this.child,
      this.title,
      this.arrowHeight,
      this.padding,
      this.arrowAngle,
      this.radius,
      this.innerPadding,
      this.strokeWidth,
      this.style) {
    this._key = new GlobalKey();
  }

  @override
  void initState() {
    super.initState();
    visible = false;
    _widgetsBinding = WidgetsBinding.instance;
    _widgetsBinding.addPostFrameCallback((callback) {
      RenderObject object = _key.currentContext.findRenderObject();
      Size mSize = object.semanticBounds.size;
      _superSetState(() {
        height = mSize.height + padding.vertical;
        width = mSize.width + padding.horizontal;
        visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      maintainSemantics: true,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: this.arrowDirection == ArrowDirection.left
                  ? MainAxisAlignment.start
                  : (this.arrowDirection == ArrowDirection.right
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: this.title,
                )
              ],
            ),
            Row(
              mainAxisAlignment: this.arrowDirection == ArrowDirection.left
                  ? MainAxisAlignment.start
                  : (this.arrowDirection == ArrowDirection.right
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Container(
                    child: BubbleWidget(
                      width,
                      height,
                      this.color,
                      this.arrowDirection == ArrowDirection.left
                          ? BubbleArrowDirection.left
                          : (this.arrowDirection == ArrowDirection.right
                          ? BubbleArrowDirection.right
                          : null),
                      borderColor: this.borderColor,
                      length: this.arrowDirection == ArrowDirection.left
                          ? height - 35
                          : 1,
                      child: OverflowBox(
                        maxWidth: MediaQuery
                            .of(context)
                            .size
                            .width - 70,
                        child: Container(
                          child: this.child,
                          key: _key,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _superSetState(callback) {
    setState(() {
      callback();
    });
  }
}
