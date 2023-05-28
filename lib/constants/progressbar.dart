import 'package:flutter/material.dart';

class LinearProgressBar extends StatelessWidget {
  final double progress;

  LinearProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          MediaQuery.of(context).size.width * 0.75, // 80% of the screen width
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          // 背景のライン
          SizedBox(
            height: 14, // Adjust the height here
            child: LinearProgressIndicator(
              value: 1.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.green.withOpacity(0.3)),
              backgroundColor: Colors.transparent,
            ),
          ),
          // 進捗を示すライン
          SizedBox(
            height: 14, // Adjust the height here
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              backgroundColor: Colors.transparent,
            ),
          ),
          // 進捗率のテキスト
          Positioned(
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Text(
                "${(progress.clamp(0.0, 1.0) * 140).round()}/140",
                style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
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
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: LinearProgressBar(progress: progressValue),
      ),
    );
  }
}
