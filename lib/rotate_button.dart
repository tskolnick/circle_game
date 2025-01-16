import 'package:flutter/material.dart';
import 'event_bus.dart';

class RotateButton extends StatelessWidget {
  final String _text;

  RotateButton(this._text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var bus = EventBus();
        bus.publish(_text);
        print('Published: ' +  _text);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Text(_text),
      ),
    );
  }
}
