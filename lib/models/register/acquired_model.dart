import 'package:flutter_riverpod/flutter_riverpod.dart';

class AcquiredController extends StateNotifier<List<int>> {
  AcquiredController() : super(List.filled(140, 0));

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

  void skip(int index) {
    state = [
      ...state.take(index),
      state[index],
      ...state.skip(index + 1),
    ];
  }
}
