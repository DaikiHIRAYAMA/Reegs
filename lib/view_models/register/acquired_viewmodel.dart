import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/acquired_model.dart';

final EIProvider = StateNotifierProvider<EIController, List<int>>((ref) {
  return EIController();
});
final NSProvider =
    StateProvider<List<int>>((ref) => List.generate(20, ((index) => 0)));
final FTProvider =
    StateProvider<List<int>>((ref) => List.generate(20, ((index) => 0)));
final JPProvider =
    StateProvider<List<int>>((ref) => List.generate(20, ((index) => 0)));

enum Question {
  q1,
  q2,
  q3,
  q4,
  q5,
  q6,
  q7,
  q8,
  q9,
  q10,
  q11,
  q12,
  q13,
  q14,
  q15,
  q16,
  q17,
  q18,
  q19,
  q20
}

const Map<Question, String> questionTexts = {
  Question.q1: '問題文 1',
  Question.q2: '問題文 2',
  Question.q3: '問題文 3',
  Question.q4: '問題文 4',
  Question.q5: '問題文 5',
  Question.q6: '問題文 6',
  Question.q7: '問題文 7',
  Question.q8: '問題文 8',
  Question.q9: '問題文 9',
  Question.q10: '問題文 10',
  Question.q11: '問題文 11',
  Question.q12: '問題文 12',
  Question.q13: '問題文 13',
  Question.q14: '問題文 14',
  Question.q15: '問題文 15',
  Question.q16: '問題文 16',
  Question.q17: '問題文 17',
  Question.q18: '問題文 18',
  Question.q19: '問題文 19',
  Question.q20: '問題文 20',
};

const Map<Question, List<String>> questionAnswers = {
  Question.q1: ['回答 1A', '回答 1B'],
  Question.q2: ['回答 2A', '回答 2B'],
  Question.q3: ['回答 3A', '回答 3B'],
  Question.q4: ['回答 4A', '回答 4B'],
  Question.q5: ['回答 5A', '回答 5B'],
  Question.q6: ['回答 6A', '回答 6B'],
  Question.q7: ['回答 7A', '回答 7B'],
  Question.q8: ['回答 8A', '回答 8B'],
  Question.q9: ['回答 9A', '回答 9B'],
  Question.q10: ['回答 10A', '回答 10B'],
  Question.q11: ['回答 11A', '回答 11B'],
  Question.q12: ['回答 12A', '回答 12B'],
  Question.q13: ['回答 13A', '回答 13B'],
  Question.q14: ['回答 14A', '回答 14B'],
  Question.q15: ['回答 15A', '回答 15B'],
  Question.q16: ['回答 16A', '回答 16B'],
  Question.q17: ['回答 17A', '回答 17B'],
  Question.q18: ['回答 18A', '回答 18B'],
  Question.q19: ['回答 19A', '回答 19B'],
  Question.q20: ['回答 20A', '回答 20B'],
};
