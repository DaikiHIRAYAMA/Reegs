import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/hsp_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart';

class HspResultViewModel {
  late final HspResult _hspResult;

  HspResultViewModel(WidgetRef ref) {
    final hspState = ref.read(HSPProvider.notifier).state;
    final hspCount = hspState.where((answer) => answer == 1).length;

    _hspResult = HspResult(hspCount: hspCount);
  }

  int get result => _hspResult.result;
}
