//友達一覧のページ

import 'package:flutter/material.dart';
import 'package:reegs/view_models/friends/friends_list_viewmodel.dart';
// import 'package:reegs/view_models/friends/friends_list_viewmodel.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  FriendListState createState() => FriendListState();
}

class FriendListState extends State<FriendListPage> {
  final FriendsListViewModel _viewModel = FriendsListViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchFriends(); // 例: 友達を取得するメソッド
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('友達一覧'),
        ),
        body: ListView.builder(
          itemCount: _viewModel.friends.length,
          itemBuilder: (context, index) {
            final friend = _viewModel.friends[index];
            return ListTile(
              title: Text(friend.name), // 例: 友達の名前を表示
              subtitle: Text(friend.userId), // 例: 友達のステータスを表示
              // 他の情報やアクションを追加することができます
            );
          },
        ),
      ),
    );
  }
}
