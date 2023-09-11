import 'package:reegs/models/register/question.dart';

class QuestionLogic {
  final List<Question> questions;

  QuestionLogic({required this.questions});

  Question getQuestion(int index) {
    return questions[index];
  }
}
