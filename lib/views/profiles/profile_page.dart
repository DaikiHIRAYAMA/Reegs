//プロフィールページ

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reegs/view_models/locations/position_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfilePage extends ConsumerWidget {
  // const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(positionViewModelProvider);
    final distance = viewModel.distance;
    return MaterialApp(
      title: 'My Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello World'),
          actions: [
            IconButton(
                // ボタンを押したサインアウト
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: const Center(
          child: Text(
            'distance',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

class $distance {}
