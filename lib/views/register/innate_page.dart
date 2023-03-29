//生年月日による分類
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zajonc/view_models/register/innate_viewmodel.dart';

class InnatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: Innate());
  }
}
