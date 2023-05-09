// MBTIによる分類

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';

class AcquiredPage extends StatefulWidget {
  final Question question;
  AcquiredPage({required this.question});

  @override
  _AcquiredPage createState() => _AcquiredPage();
}

class _AcquiredPage extends State<AcquiredPage> {
  Question? _selectetedQuestionValue;

  _selectedQuestion(Question? value) {
    setState(() {
      _selectetedQuestionValue = value;
    });
    if (widget.question == Question.q20) {
      //最後の質問の場合、別の画面に遷移する
    } else {
      //次の質問に遷移
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AcquiredPage(
            question: Question.values[widget.question.index + 1],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${widget.question.index + 1}'),
      ),
      backgroundColor: const Color.fromRGBO(255, 244, 213, 1),
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'koko ni shitsumon ga hairuyo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 200, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: Question.values[widget.question.index * 2],
                    groupValue: _selectetedQuestionValue,
                    onChanged: ((value) =>
                        _selectedQuestion(value as Question)),
                    title: const Text('select A'),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: Question.values[widget.question.index * 2 + 1],
                    groupValue: _selectetedQuestionValue,
                    onChanged: ((value) =>
                        _selectedQuestion(value as Question)),
                    title: const Text('select B'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
