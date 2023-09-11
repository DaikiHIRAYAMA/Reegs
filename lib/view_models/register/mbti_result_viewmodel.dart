import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/mbti_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';

class MbtiResultViewModel {
  final WidgetRef _ref;

  MbtiResultViewModel(this._ref);

  String get result {
    final eiState = _ref.read(EIProvider);
    final nsState = _ref.read(NSProvider);
    final ftState = _ref.read(FTProvider);
    final jpState = _ref.read(JPProvider);

    final eiTotal = eiState.reduce((a, b) => a + b);
    final nsTotal = nsState.reduce((a, b) => a + b);
    final ftTotal = ftState.reduce((a, b) => a + b);
    final jpTotal = jpState.reduce((a, b) => a + b);

    // 合計値をもとにE/I、S/N、F/T、J/Pの結果を取得
    final eiResult = eiTotal >= 0 ? 'E' : 'I';
    final nsResult = nsTotal >= 0 ? 'S' : 'N';
    final ftResult = ftTotal >= 0 ? 'F' : 'T';
    final jpResult = jpTotal >= 0 ? 'J' : 'P';

    return eiResult + nsResult + ftResult + jpResult;
  }
}
