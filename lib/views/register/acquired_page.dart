// MBTIによる分類

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:reegs/views/login/login_page.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';
// import 'package:riverpod/riverpod.dart';

class AcquiredPage extends ConsumerStatefulWidget {
  final Question question;
  AcquiredPage({required this.question});

  @override
  _AcquiredPage createState() => _AcquiredPage();
}

class _AcquiredPage extends ConsumerState<AcquiredPage> {
  Question? _selectetedQuestionValue;
  int? _selectedAnswerIndex;

  _selectedQuestion(Question? value) {
    setState(() {
      _selectetedQuestionValue = value;
    });
    if (widget.question == Question.q64) {
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

  _selectedAnswer(int? value) {
    setState(() {
      _selectedAnswerIndex = value;
    });

    if (value != null) {
      print(value);
      //回答に基づいて配列を選択して加算
      switch (value) {
        //EI判断
        case 10:
          ref.read(EIProvider.notifier).increment(widget.question.index);
          break;
        case 11:
          ref.read(EIProvider.notifier).decrement(widget.question.index);
          break;
        //NS判断
        case 20:
          ref.read(NSProvider.notifier).decrement(widget.question.index);
          break;
        case 21:
          ref.read(NSProvider.notifier).decrement(widget.question.index);
          break;
        //FT判断
        case 30:
          ref.read(FTProvider.notifier).decrement(widget.question.index);
          break;
        case 31:
          ref.read(FTProvider.notifier).decrement(widget.question.index);
          break;
        //JP判断
        case 40:
          ref.read(JPProvider.notifier).decrement(widget.question.index);
          break;
        case 41:
          ref.read(JPProvider.notifier).decrement(widget.question.index);
          break;
        //DSM
        case 50:
          ref.read(HSPProvider.notifier).decrement(widget.question.index);
          break;
        case 51:
          ref.read(HSPProvider.notifier).decrement(widget.question.index);
          break;
      }
    }
    _selectedQuestion(widget.question.index == Question.values.length - 1
        ? null
        : Question.values[widget.question.index + 1]);
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
            Text(
              questionTexts[widget.question]!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 200, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: questionClass[widget.question]! + 0,
                    groupValue: _selectedAnswerIndex,
                    onChanged: ((value) => _selectedAnswer(value as int)),
                    title:
                        Text(questionAnswers[widget.question]![0]), //回答Aのテキスト
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: RadioListTile(
                    value: questionClass[widget.question]! + 1,
                    groupValue: _selectedAnswerIndex,
                    onChanged: ((value) => _selectedAnswer(value as int)),
                    title:
                        Text(questionAnswers[widget.question]![1]), //回答Bのテキスト
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
