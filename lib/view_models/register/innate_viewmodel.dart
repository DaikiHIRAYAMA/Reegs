import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:state_notifier/state_notifier.dart';

final birthdayProvider = StateProvider<DateTime>((ref) => DateTime.now());
final birthdayNotifierProvider =
    StateNotifierProvider<BirthdayNotifier, DateTime>(
        (ref) => BirthdayNotifier());

class BirthdayNotifier extends StateNotifier<DateTime> {
  BirthdayNotifier() : super(DateTime.now());

  void registerBirthday(DateTime birthday) {
    state = birthday;
  }
}

class Innate extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birthdayNotifier = ref.watch(birthdayProvider.notifier);
    final birthday = ref.watch(birthdayProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${birthday.year}年${birthday.month}月${birthday.day}日"),
            ElevatedButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 1, 1),
                      maxTime: DateTime.now(),
                      theme: const DatePickerTheme(
                          headerColor: Colors.green,
                          backgroundColor: Colors.black,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date');
                    birthdayNotifier.state = date;
                    // Text('Birthday: ${birthday.toString()}');
                  }, onConfirm: (date) {
                    print('confirm $date');
                    birthdayNotifier.state = date;
                    // Text('Birthday: ${birthday.toString()}');
                  }, currentTime: DateTime.now(), locale: LocaleType.jp);
                },
                child: const Text(
                  '生年月日を入力してね',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/acquired');
                },
                child: const Text('NEXT'))
          ],
        ),
      ),
    );
  }
}
