import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/psy_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';

class PsyResultViewModel {
  late final PsyResult _psyResult;

  PsyResultViewModel(WidgetRef ref) {
    final psyState = ref.read(PsyProvider.notifier).state;
    final psyCount = psyState.where((answer) => answer == 1).length;

    _psyResult = PsyResult(psyCount: psyCount);
  }

  int get result => _psyResult.result;
}
