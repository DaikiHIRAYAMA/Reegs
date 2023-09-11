import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/constants/appbar.dart';
import 'package:reegs/index.dart';
import 'package:reegs/models/register/hsp_result_model.dart';
import 'package:reegs/models/register/mbti_result_model.dart';
import 'package:reegs/models/register/psy_result_model.dart';
import 'package:reegs/models/register/soc_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';
import 'package:reegs/view_models/register/diagnosis_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reegs/constants/elevated_button.dart';

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
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$userId-$diagnosisKey', true);
  }

  Future<void> _saveResultsAndCompleteDiagnosis(String diagnosisKey,
      {required Map<String, dynamic> results}) async {
    final firestore = FirebaseFirestore.instance;
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await firestore.collection('diagnosis-results').doc(userId).set(results);
    await completeDiagnosis(diagnosisKey);
  }

  void navigateToNextScreen({required Widget nextPage}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  _selectedQuestion(Question? value) async {
    setState(() {
      _selectetedQuestionValue = value;
    });

    if (widget.question == Question.q140) {
      final diagnosisViewModel = DiagnosisViewModel();
      await diagnosisViewModel.saveResultsAndCompleteDiagnosis(ref);
      final results = await diagnosisViewModel.fetchAllResults(ref);
      print('MbtiResultの値: ${results.mbtiResult}');

      _saveResultsAndCompleteDiagnosis(
        'profile_complete',
        results: {
          'mbti_result': results.mbtiResult,
          'hsp_result': results.hspResult,
          'psy_result': results.psyResult,
          'soc_result': results.socResult,
          'en_result': results.enResult,
        },
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
        print('Error occurred while saving data: $error');
      });
    } else {
      // Navigate to next question
      navigateToNextScreen(
          nextPage: AcquiredPage(
              question: Question.values[widget.question.index + 1]));
    }
  }

  _selectedAnswer(int? value) {
    setState(() {
      _selectedAnswerIndex = value;
    });

    _selectedQuestion(widget.question.index == Question.values.length - 1
        ? null
        : Question.values[widget.question.index + 1]);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: CustomAppBar(
          currentIndex: widget.question.index,
          totalQuestions: 140,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Container(
                  height: screenSize.height * 0.2,
                  alignment: Alignment.center,
                  child: Text(
                    questionTexts[widget.question]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              CustomElevatedButton(
                backgroundColor: Color.fromARGB(255, 120, 171, 74),
                text: questionAnswers[widget.question]![0],
                onPressed: () =>
                    _selectedAnswer(questionClass[widget.question]! + 0),
              ),
              SizedBox(height: screenSize.height * 0.05),
              CustomElevatedButton(
                backgroundColor: Color.fromARGB(255, 249, 84, 40),
                text: questionAnswers[widget.question]![1],
                onPressed: () =>
                    _selectedAnswer(questionClass[widget.question]! + 1),
              ),
              SizedBox(height: screenSize.height * 0.1),
              CustomElevatedButton(
                backgroundColor: Color.fromARGB(255, 245, 238, 227),
                text: "どちらでもない / 不明",
                onPressed: () =>
                    _selectedAnswer(questionClass[widget.question]! + 2),
                fontSize: 20,
                widthFactor: 0.75,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// enum AnswerAction { increment, decrement, skip }

// // Add your mapping functions here
// ProviderNotifier determineProviderNotifier(int value) {
//   // Replace with your actual mapping logic
//   return EIProvider.notifier; // Placeholder return
// }

// AnswerAction determineAction(int value) {
//   // Replace with your actual mapping logic
//   return AnswerAction.increment; // Placeholder return
// }
