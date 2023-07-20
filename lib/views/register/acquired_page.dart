//処理をViewModel等にリファクタリングする
// MBTIによる分類
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/constants/progressbar.dart';
import 'package:reegs/index.dart';
import 'package:reegs/views/register/send_confirmation_page.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Future<void> completeDiagnosis(String diagnosisKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(diagnosisKey, true);
  }

  Future<void> saveResultsAndCompleteDiagnosis(
    String diagnosisKey,
    String eiResult,
    String nsResult,
    String ftResult,
    String jpResult,
    String mbtiResult,
    int hspResult,
    int psyResult,
    int socResult,
    int en1Result,
    int en2Result,
    int en3Result,
    int en4Result,
    int en5Result,
    int en6Result,
    int en7Result,
    int en8Result,
    int en9Result,
    int enResult,
  ) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('diagnosis-results').add({
      'mbti_result': mbtiResult,
      'hsp_result': hspResult,
      'psy_result': psyResult,
      'soc_result': socResult,
      'en_result': enResult,
      // add more fields as needed
    });
    await completeDiagnosis('test_complete');
  }

  _selectedQuestion(Question? value) async {
    setState(() {
      _selectetedQuestionValue = value;
    });

    if (widget.question == Question.q140) {
      //最後の質問の場合、別の画面に遷移する
      //MBTIの結果取得
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
      final eiResult = eiTotal >= 0 ? 'E' : 'I';
      final nsResult = nsTotal >= 0 ? 'S' : 'N';
      final ftResult = ftTotal >= 0 ? 'F' : 'T';
      final jpResult = jpTotal >= 0 ? 'J' : 'P';
      final mbtiResult = eiResult + nsResult + ftResult + jpResult;

      //hspの結果取得
      final hspState = ref.read(HSPProvider.notifier).state;
      final hspCount = hspState.where((answer) => answer == 1).length;
      final hspResult = hspCount >= 14 ? 1 : 0;

      //psyの診断結果
      final psyState = ref.read(PsyProvider.notifier).state;
      final psyCount = psyState.where((answer) => answer == 1).length;
      final psyResult = psyCount >= 5 ? 1 : 0;

      //psyの診断結果
      final socState = ref.read(SocProvider.notifier).state;
      final socCount = socState.where((answer) => answer == 1).length;
      final socResult = socCount >= 6 ? 1 : 0;

      //エニアグラムの診断結果
      final en1State = ref.read(En1Provider.notifier).state;
      final en2State = ref.read(En2Provider.notifier).state;
      final en3State = ref.read(En3Provider.notifier).state;
      final en4State = ref.read(En4Provider.notifier).state;
      final en5State = ref.read(En5Provider.notifier).state;
      final en6State = ref.read(En6Provider.notifier).state;
      final en7State = ref.read(En7Provider.notifier).state;
      final en8State = ref.read(En8Provider.notifier).state;
      final en9State = ref.read(En9Provider.notifier).state;

      // 各項目のYESのカウント
      final en1Result = en1State.where((answer) => answer == 1).length;
      final en2Result = en2State.where((answer) => answer == 1).length;
      final en3Result = en3State.where((answer) => answer == 1).length;
      final en4Result = en4State.where((answer) => answer == 1).length;
      final en5Result = en5State.where((answer) => answer == 1).length;
      final en6Result = en6State.where((answer) => answer == 1).length;
      final en7Result = en7State.where((answer) => answer == 1).length;
      final en8Result = en8State.where((answer) => answer == 1).length;
      final en9Result = en9State.where((answer) => answer == 1).length;

      List<int> counts = [
        en1Result,
        en2Result,
        en3Result,
        en4Result,
        en5Result,
        en6Result,
        en7Result,
        en8Result,
        en9Result,
      ];

      // 最大カウント数を取得
      var maxCount = counts.reduce(max);

      // 最大カウント数の項目をリストアップ（複数存在する場合も含む）
      var maxCountIndices = counts
          .asMap()
          .entries
          .where((entry) => entry.value == maxCount)
          .map((entry) => entry.key)
          .toList();

      // ランダムに1つ選ぶ
      var rnd = Random();
      final enResult = maxCountIndices[rnd.nextInt(maxCountIndices.length)];

      saveResultsAndCompleteDiagnosis(
        'profile_complete',
        eiResult,
        nsResult,
        ftResult,
        jpResult,
        mbtiResult,
        hspResult,
        psyResult,
        socResult,
        en1Result,
        en2Result,
        en3Result,
        en4Result,
        en5Result,
        en6Result,
        en7Result,
        en8Result,
        en9Result,
        enResult,
      ).then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LiquidSwipeViews(),
          ),
          // MaterialPageRoute(
          //   builder: (context) =>
          //       SendConfirmationPage(eiResult, nsResult, ftResult, jpResult),
          // ),
        );
      }).catchError((error) {
        print('An error occurred while saving the data: $error');
      });
      print(eiResult);
      print(nsResult);
      print(ftResult);
      print(jpResult);
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
        //iwayuru 質問
        case 0:
          ref.read(iwayuruProvider.notifier).increment(widget.question.index);
          break;
        case 1:
          ref.read(iwayuruProvider.notifier).increment(widget.question.index);
          break;
        case 2:
          ref.read(iwayuruProvider.notifier).skip(widget.question.index);
          break;

        //EI判断
        case 10:
          ref.read(EIProvider.notifier).increment(widget.question.index);
          break;
        case 11:
          ref.read(EIProvider.notifier).decrement(widget.question.index);
          break;
        case 12:
          ref.read(EIProvider.notifier).skip(widget.question.index);
          break;
        //NS判断
        case 20:
          ref.read(NSProvider.notifier).increment(widget.question.index);
          break;
        case 21:
          ref.read(NSProvider.notifier).decrement(widget.question.index);
          break;
        case 22:
          ref.read(EIProvider.notifier).skip(widget.question.index);
          break;
        //FT判断
        case 30:
          ref.read(FTProvider.notifier).increment(widget.question.index);
          break;
        case 31:
          ref.read(FTProvider.notifier).decrement(widget.question.index);
          break;
        case 32:
          ref.read(FTProvider.notifier).skip(widget.question.index);
          break;
        //JP判断
        case 40:
          ref.read(JPProvider.notifier).increment(widget.question.index);
          break;
        case 41:
          ref.read(JPProvider.notifier).decrement(widget.question.index);
          break;
        case 42:
          ref.read(JPProvider.notifier).skip(widget.question.index);
          break;
        //HSP
        case 50:
          ref.read(HSPProvider.notifier).increment(widget.question.index);
          break;
        case 51:
          ref.read(HSPProvider.notifier).decrement(widget.question.index);
          break;
        case 52:
          ref.read(HSPProvider.notifier).skip(widget.question.index);
          break;
        //サイコパス
        case 60:
          ref.read(PsyProvider.notifier).increment(widget.question.index);
          break;
        case 61:
          ref.read(PsyProvider.notifier).decrement(widget.question.index);
          break;
        case 62:
          ref.read(PsyProvider.notifier).skip(widget.question.index);
          break;
        //ソシオパス
        case 70:
          ref.read(SocProvider.notifier).increment(widget.question.index);
          break;
        case 71:
          ref.read(SocProvider.notifier).decrement(widget.question.index);
          break;
        case 72:
          ref.read(SocProvider.notifier).skip(widget.question.index);
          break;
        // type1
        case 110:
          ref.read(En1Provider.notifier).increment(widget.question.index);
          break;
        case 111:
          ref.read(En1Provider.notifier).decrement(widget.question.index);
          break;
        case 112:
          ref.read(En1Provider.notifier).skip(widget.question.index);
          break;
        // type2
        case 120:
          ref.read(En2Provider.notifier).increment(widget.question.index);
          break;
        case 121:
          ref.read(En2Provider.notifier).decrement(widget.question.index);
          break;
        case 122:
          ref.read(En2Provider.notifier).skip(widget.question.index);
          break;
        // type3
        case 130:
          ref.read(En3Provider.notifier).increment(widget.question.index);
          break;
        case 131:
          ref.read(En3Provider.notifier).decrement(widget.question.index);
          break;
        case 132:
          ref.read(En3Provider.notifier).skip(widget.question.index);
          break;
        // type4
        case 140:
          ref.read(En4Provider.notifier).increment(widget.question.index);
          break;
        case 141:
          ref.read(En4Provider.notifier).decrement(widget.question.index);
          break;
        case 142:
          ref.read(En4Provider.notifier).skip(widget.question.index);
          break;
        // type5
        case 150:
          ref.read(En5Provider.notifier).increment(widget.question.index);
          break;
        case 151:
          ref.read(En5Provider.notifier).decrement(widget.question.index);
          break;
        case 152:
          ref.read(En5Provider.notifier).skip(widget.question.index);
          break;
        // type6
        case 160:
          ref.read(En6Provider.notifier).increment(widget.question.index);
          break;
        case 161:
          ref.read(En6Provider.notifier).decrement(widget.question.index);
          break;
        case 162:
          ref.read(En6Provider.notifier).skip(widget.question.index);
          break;
        // type7
        case 170:
          ref.read(En7Provider.notifier).increment(widget.question.index);
          break;
        case 171:
          ref.read(En7Provider.notifier).decrement(widget.question.index);
          break;
        case 172:
          ref.read(En7Provider.notifier).skip(widget.question.index);
          break;
        // type8
        case 180:
          ref.read(En8Provider.notifier).increment(widget.question.index);
          break;
        case 181:
          ref.read(En8Provider.notifier).decrement(widget.question.index);
          break;
        case 182:
          ref.read(En8Provider.notifier).skip(widget.question.index);
          break;
        // type9
        case 190:
          ref.read(En9Provider.notifier).increment(widget.question.index);
          break;
        case 191:
          ref.read(En9Provider.notifier).decrement(widget.question.index);
          break;
        case 192:
          ref.read(En9Provider.notifier).skip(widget.question.index);
          break;
      }
    }
    _selectedQuestion(widget.question.index == Question.values.length - 1
        ? null
        : Question.values[widget.question.index + 1]);
  }

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.75;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            // 戻るボタン
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          title: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('lib/assets/images/splashes/splash.png'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                LinearProgressBar(
                  progress: ((widget.question.index + 1) / 140),
                ),
                Text(
                  '${widget.question.index + 1}/140',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          actions: [
            // The dummy widget has the same size as the leading widget, to balance the AppBar
            Container(width: MediaQuery.of(context).size.width * 0.125),
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  alignment: Alignment.center,
                  child: Text(
                    questionTexts[widget.question]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.75, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: Color.fromARGB(255, 120, 171, 74),
                    ),
                    onPressed: () =>
                        _selectedAnswer(questionClass[widget.question]! + 0),
                    child: Text(
                      questionAnswers[widget.question]![0], //回答Aのテキスト
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.75, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: const Color.fromARGB(255, 249, 84, 40),
                    ),
                    onPressed: () =>
                        _selectedAnswer(questionClass[widget.question]! + 1),
                    child: Text(
                      questionAnswers[widget.question]![1], //回答Bのテキスト
                      style: const TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      fixedSize: Size(buttonWidth, 50),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      backgroundColor: const Color.fromARGB(255, 245, 238, 227),
                    ),
                    onPressed: () =>
                        _selectedAnswer(questionClass[widget.question]! + 2),
                    child: const Text(
                      "どちらでもない / 不明",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
