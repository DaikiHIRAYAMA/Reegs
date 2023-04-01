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
      appBar: AppBar(
        title: const Text('Select Your Position'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 50.0,
            ),
            Card(
              color: Colors.white,
              child: Column(children: [
                RadioListTile(
                  title: const Text('Eldest'),
                  value: PositionValue.Eldest,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.red),
                    Icon(Icons.person, size: 36, color: Colors.black),
                    Icon(Icons.person, size: 30, color: Colors.black),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Middle'),
                  value: PositionValue.Middle,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.black),
                    Icon(Icons.person, size: 36, color: Colors.red),
                    Icon(Icons.person, size: 30, color: Colors.black),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Youngest'),
                  value: PositionValue.Youngest,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.black),
                    Icon(Icons.person, size: 36, color: Colors.black),
                    Icon(Icons.person, size: 30, color: Colors.red),
                  ],
                ),
              ]),
            ),
            Card(
              child: Column(children: [
                RadioListTile(
                  title: const Text('Only'),
                  value: PositionValue.Only,
                  groupValue: _positionValue,
                  onChanged: (value) => _onRadioSelected(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.person, size: 48, color: Colors.red),
                  ],
                ),
              ]),
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
