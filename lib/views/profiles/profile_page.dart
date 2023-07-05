//プロフィールページ

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reegs/view_models/locations/position_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyProfilePage extends ConsumerWidget {
  // const MyProfilePage({Key? key}) : super(key: key);
  final firestore = FirebaseFirestore.instance;
  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('diagnosis-results');
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
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: collectionRef.get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final doc = snapshot.data!.docs.first;
              final mbtiResult = doc.get('mbti_result');

              return Text(mbtiResult);
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}

class $distance {}
