import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/models/register/enneagram_result_model.dart';
import 'package:reegs/view_models/register/acquired_viewmodel.dart'; // EnneagramResultモデルのインポート

class EnneagramResultViewModel {
  late final EnneagramResult _enneagramResult;

  EnneagramResultViewModel(WidgetRef ref) {
    final enStates = [
      ref.read(En1Provider),
      ref.read(En2Provider),
      ref.read(En3Provider),
      ref.read(En4Provider),
      ref.read(En5Provider),
      ref.read(En6Provider),
      ref.read(En7Provider),
      ref.read(En8Provider),
      ref.read(En9Provider),
    ];

    final counts = enStates
        .map((state) => state.where((answer) => answer == 1).length)
        .toList();

    var maxCount = counts.reduce(max);
    var maxCountIndices = counts
        .asMap()
        .entries
        .where((entry) => entry.value == maxCount)
        .map((entry) => entry.key)
        .toList();

    var rnd = Random();
    final enResult = maxCountIndices[rnd.nextInt(maxCountIndices.length)];

    _enneagramResult = EnneagramResult(counts: counts, enResult: enResult);
  }

  int get result => _enneagramResult.enResult;
}
