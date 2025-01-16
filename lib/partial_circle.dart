import 'dart:math';
import 'package:flutter/material.dart';
import 'event_bus.dart';
import 'dart:async';

class PartialCircle extends StatefulWidget {
  @override
  _PartialCircleState createState() => _PartialCircleState();
}

class _PartialCircleState extends State<PartialCircle> {
  double _angle = 0;
  late StreamSubscription _subscription;

  @override

  void initState() {
    super.initState();
    var bus = EventBus();

    _subscription = bus.eventStream.listen((event) {
      if (event == 'left') {
        rotateLeft();    
      } else if (event == 'right') {
        rotateRight();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void rotateLeft() {
    setState(() {
      _angle -= 10;
    });
  }

  void rotateRight() {
    setState(() {
      _angle += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PartialCirclePainter(_angle),
      child: Container(
        width: 100,
        height: 100,
      ),
    );
  }
}

class PartialCirclePainter extends CustomPainter {
  final double _angle;

  PartialCirclePainter(this._angle);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final double startAngle = _angle * pi / 180;
    final double sweepAngle = (360 - 20) * pi / 180;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(PartialCirclePainter oldDelegate) {
    return oldDelegate._angle != _angle;
  }
}