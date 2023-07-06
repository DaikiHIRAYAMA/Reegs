import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final double progress;

  LinearProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: 14,
          child: LinearProgressIndicator(
            value: 1.0,
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.green.withOpacity(0.3)),
            backgroundColor: Colors.transparent,
          ),
        ),
        SizedBox(
          height: 14,
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            backgroundColor: Colors.transparent,
          ),
        ),
      ],
    );
  }
}

class ContentView extends StatefulWidget {
  @override
  _ContentViewState createState() => _ContentViewState();
}

class _ContentViewState extends State<ContentView> {
  double progressValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LinearProgressBar(progress: progressValue),
    );
  }
}
