import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/soc_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart'; // SocResultモデルのインポートを忘れずに

class SocResultViewModel {
  late final SocResult _socResult;

  SocResultViewModel(WidgetRef ref) {
    final socState = ref.read(SocProvider.notifier).state;
    final socCount = socState.where((answer) => answer == 1).length;

    _socResult = SocResult(socCount: socCount);
  }

  int get result => _socResult.socCount;
}
