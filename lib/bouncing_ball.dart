import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

class BouncingBall extends StatefulWidget {
  @override
  _BouncingBallState createState() => _BouncingBallState();
}

class _BouncingBallState extends State<BouncingBall> {
  double _ballX = 100;
  double _ballY = 100;
  double _ballSpeedX = 2;
  double _ballSpeedY = 2;
  double _ballRadius = 20;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _animate();
  }

  void _animate() {
    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      setState(() {
        _ballX += _ballSpeedX;
        _ballY += _ballSpeedY;

        // Collision with edges
        if (_ballX - _ballRadius < 0 || _ballX + _ballRadius > MediaQuery.of(context).size.width) {
          _ballSpeedX = -_ballSpeedX;
        }
        if (_ballY - _ballRadius < 0 || _ballY + _ballRadius > MediaQuery.of(context).size.height) {
          _ballSpeedY = -_ballSpeedY;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _ballX - _ballRadius,
      top: _ballY - _ballRadius,
      child: Container(
        width: _ballRadius * 2,
        height: _ballRadius * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
      ),
    );
  }
}