
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:flame/flame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();


  Flame.device.fullScreen();
  Flame.device.setPortrait();
  runApp(GameApp());  
}