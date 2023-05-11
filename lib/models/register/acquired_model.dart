import 'package:flutter_riverpod/flutter_riverpod.dart';

class EIController extends StateNotifier<List<int>> {
  EIController()
      : super([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]);

  void increment(int index) {
    state = [
      ...state.take(index),
      state[index] + 1,
      ...state.skip(index + 1),
    ];
  }

  void decrement(int index) {
    state = [
      ...state.take(index),
      state[index] - 1,
      ...state.skip(index + 1),
    ];
  }
}
