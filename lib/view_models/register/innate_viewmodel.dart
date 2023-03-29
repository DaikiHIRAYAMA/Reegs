import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final birthdayProvider = StateProvider<DateTime>((ref) => DateTime.now());

class Innate extends ConsumerWidget {
  const Innate({super.key});

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
            ElevatedButton(
                onPressed: () {
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 1, 1),
                      maxTime: DateTime.now(),
                      theme: const DatePickerTheme(
                          headerColor: Colors.orange,
                          backgroundColor: Colors.blue,
                          itemStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          doneStyle:
                              TextStyle(color: Colors.white, fontSize: 16)),
                      onChanged: (date) {
                    print('change $date');
                    birthdayNotifier.state = date;
                  }, onConfirm: (date) {
                    print('confirm $date');
                    birthdayNotifier.state = date;
                  }, currentTime: DateTime.now(), locale: LocaleType.jp);
                },
                child: const Text(
                  '生年月日を入力してね',
                  style: TextStyle(color: Colors.black),
                )),
            Text("${birthday.year}年${birthday.month}月${birthday.day}日")
          ],
        ),
      ),
    );
  }
}
