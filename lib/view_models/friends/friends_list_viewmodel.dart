import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:reegs/models/friends/friend.model.dart';

class FriendsListViewModel extends ChangeNotifier {
  List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  void fetchFriends() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').get();

    _friends = snapshot.docs.map((doc) {
      return Friend(
        name: doc['name'], // フィールド名に応じて変更
        userId: doc['userId'], // フィールド名に応じて変更
      );
    }).toList();

    notifyListeners(); // UIを更新
  }
}
