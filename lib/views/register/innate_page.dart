//生年月日による分類
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:zajonc/constants/snackbar.dart';
import 'package:zajonc/view_models/register/innate_viewmodel.dart';

class InnatePage extends StatefulWidget {
  @override
  State<InnatePage> createState() => InnatePageState();
}

class InnatePageState extends State<InnatePage> {
  final _birthdayController = TextEditingController();
  var _loading = false;

// これの関数を他のページで使用する際は、Riverpod等を用いる必要がある
  Future<void> _getCharacter() async {
    setState(() {
      _loading = true;
    });

    try {
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('characters')
          .select()
          .eq('id', userId)
          .single() as Map;
      _birthdayController.text = (data['username'] ?? '') as String;
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected exception occurred');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<void> _registerBirthday() async {
    setState(() {
      _loading = true;
    });
    final birthday = _birthdayController;
    final user = supabase.auth.currentUser;
    final updates = {
      'id': user!.id,
      'birthday': birthday,
      'updated_at': DateTime.now().toIso8601String(),
    };
    try {
      await supabase.from('characters').upsert(updates);
      if (mounted) {
        context.showSnackBar(message: '生年月日を登録しました'); //TODO
      }
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _registerBirthday();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Innate());
  }
}
