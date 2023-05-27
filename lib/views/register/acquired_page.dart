// MBTIによる分類

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/views/profiles/profile_page.dart';
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

  _selectedQuestion(Question? value) async {
    setState(() {
      _selectetedQuestionValue = value;
    });

    if (widget.question == Question.q138) {
      //最後の質問の場合、別の画面に遷移する
      final eiState = ref.read(EIProvider.notifier).state;
      final nsState = ref.read(NSProvider.notifier).state;
      final ftState = ref.read(FTProvider.notifier).state;
      final jpState = ref.read(JPProvider.notifier).state;

      // 各状態から合計値を計算します。
      final eiTotal = eiState.reduce((a, b) => a + b);
      final nsTotal = nsState.reduce((a, b) => a + b);
      final ftTotal = ftState.reduce((a, b) => a + b);
      final jpTotal = jpState.reduce((a, b) => a + b);

      // 合計値をもとにYESかNOのどちらが多いかを判断します。なんて名前にするのか判断する
      final eiResult = eiTotal >= 0 ? 'YES' : 'NO';
      final nsResult = nsTotal >= 0 ? 'YES' : 'NO';
      final ftResult = ftTotal >= 0 ? 'YES' : 'NO';
      final jpResult = jpTotal >= 0 ? 'YES' : 'NO';

      // Create a client object
      final client = Supabase.instance.client;
      try {
        final response = await client
            .from('your-table-name') // replace with your table name
            .insert({
          'ei_result': eiResult,
          'ns_result': nsResult,
          'ft_result': ftResult,
          'jp_result': jpResult,
          // add more columns as needed
        }).execute();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfilePage(),
          ),
        );
      } catch (error) {
        print('An error occurred while saving the data: $error');
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyProfilePage(), // replace with your next page
        ),
      );
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
          ref.read(NSProvider.notifier).increment(widget.question.index);
          break;
        case 21:
          ref.read(NSProvider.notifier).decrement(widget.question.index);
          break;
        //FT判断
        case 30:
          ref.read(FTProvider.notifier).increment(widget.question.index);
          break;
        case 31:
          ref.read(FTProvider.notifier).decrement(widget.question.index);
          break;
        //JP判断
        case 40:
          ref.read(JPProvider.notifier).increment(widget.question.index);
          break;
        case 41:
          ref.read(JPProvider.notifier).decrement(widget.question.index);
          break;
        //HSP
        case 50:
          ref.read(HSPProvider.notifier).increment(widget.question.index);
          break;
        case 51:
          ref.read(HSPProvider.notifier).decrement(widget.question.index);
          break;
        //サイコパス
        case 60:
          ref.read(PsyProvider.notifier).increment(widget.question.index);
          break;
        case 61:
          ref.read(PsyProvider.notifier).decrement(widget.question.index);
          break;
        //ソシオパス
        case 70:
          ref.read(SocProvider.notifier).increment(widget.question.index);
          break;
        case 71:
          ref.read(SocProvider.notifier).decrement(widget.question.index);
          break;
        // type1
        case 110:
          ref.read(En1Provider.notifier).increment(widget.question.index);
          break;
        case 111:
          ref.read(En1Provider.notifier).decrement(widget.question.index);
          break;
        // type2
        case 120:
          ref.read(En2Provider.notifier).increment(widget.question.index);
          break;
        case 121:
          ref.read(En2Provider.notifier).decrement(widget.question.index);
          break;
        // type3
        case 130:
          ref.read(En3Provider.notifier).increment(widget.question.index);
          break;
        case 131:
          ref.read(En3Provider.notifier).decrement(widget.question.index);
          break;
        // type4
        case 140:
          ref.read(En4Provider.notifier).increment(widget.question.index);
          break;
        case 141:
          ref.read(En4Provider.notifier).decrement(widget.question.index);
          break;
        // type5
        case 150:
          ref.read(En5Provider.notifier).increment(widget.question.index);
          break;
        case 151:
          ref.read(En5Provider.notifier).decrement(widget.question.index);
          break;
        // type6
        case 160:
          ref.read(En6Provider.notifier).increment(widget.question.index);
          break;
        case 161:
          ref.read(En6Provider.notifier).decrement(widget.question.index);
          break;
        // type7
        case 170:
          ref.read(En7Provider.notifier).increment(widget.question.index);
          break;
        case 171:
          ref.read(En7Provider.notifier).decrement(widget.question.index);
          break;
        // type8
        case 180:
          ref.read(En8Provider.notifier).increment(widget.question.index);
          break;
        case 181:
          ref.read(En8Provider.notifier).decrement(widget.question.index);
          break;
        // type9
        case 190:
          ref.read(En9Provider.notifier).increment(widget.question.index);
          break;
        case 191:
          ref.read(En9Provider.notifier).decrement(widget.question.index);
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
