//兄弟構成

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PositionPage extends StatefulWidget {
  @override
  _PositionPageState createState() => _PositionPageState();
}

enum PositionValue { Eldest, Middle, Youngest, Only }

class _PositionPageState extends State<PositionPage> {
  PositionValue _positionValue = PositionValue.Eldest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            RadioListTile(
              title: Text('長子'),
              value: PositionValue.Eldest,
              groupValue: _positionValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
            RadioListTile(
              title: Text('中間子'),
              value: PositionValue.Middle,
              groupValue: _positionValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
            RadioListTile(
              title: Text('末子'),
              value: PositionValue.Youngest,
              groupValue: _positionValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
            RadioListTile(
              title: Text('一人っ子'),
              value: PositionValue.Only,
              groupValue: _positionValue,
              onChanged: (value) => _onRadioSelected(value),
            ),
          ],
        ),
      ),
    );
  }

  _onRadioSelected(value) {
    setState(() {
      _positionValue = value;
    });
  }
}
