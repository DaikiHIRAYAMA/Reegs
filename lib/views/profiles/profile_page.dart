import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reegs/constants/appbar.dart';

class MyProfilePage extends ConsumerWidget {
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestore = FirebaseFirestore.instance;
    final collectionRef = firestore.collection('diagnosis-results');

    return MaterialApp(
      title: 'My Page',
      theme: ThemeData(
        primarySwatch: Colors.green,
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.black, // これがタブのテキストの色を制御します
        ),
      ),
      home: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Page'),
            actions: [
              IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: FutureBuilder<QuerySnapshot>(
            future: collectionRef.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final doc = snapshot.data!.docs.first;
                final mbtiResult = doc.get('mbti_result');
                final hspResult = doc.get('hsp_result');
                final psyResult = doc.get('psy_result');
                final socResult = doc.get('soc_result');
                final enResult = doc.get('en_result');

                return Column(
                  children: [
                    //画像表示
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset(
                          'lib/assets/images/MBTI/$mbtiResult.png',
                          fit: BoxFit.contain),
                    ),
                    const TabBar(
                      tabs: [
                        Tab(text: '先天的'),
                        Tab(text: '後天的'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          // Second Tab
                          const Center(child: Text('占いの内容')),
                          // First Tab
                          Column(
                            children: [
                              const Text('MBTIの内容'),
                              Text('MBTI Result: $mbtiResult'),
                              Text('HSP Result: $hspResult'),
                              Text('PSY Result: $psyResult'),
                              Text('SOC Result: $socResult'),
                              Text('En Result: $enResult'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}
