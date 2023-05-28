//プロフィールページ

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/view_models/locations/position_view_model.dart';

class MyProfilePage extends ConsumerWidget {
  // const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(positionViewModelProvider);
    final distance = viewModel.distance;

    return Text(
      'Distance: ${distance ?? 'Unavailable'} meters',
    );
  }
}
