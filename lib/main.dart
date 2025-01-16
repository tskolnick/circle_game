import 'package:flutter/material.dart';
import 'bouncing_ball.dart'; // Import the BouncingBall widget
import 'partial_circle.dart'; // Import the PartialCircle widget
import 'rotate_button.dart'; // Import the RotateButton widget

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
            
              Center(
                child: PartialCircle(),
              ),
              BouncingBall(),
            
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    Expanded(
                      child: RotateButton( 'left',)  
                    ),
                    Expanded(
                      child: RotateButton( 'right',) 
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}