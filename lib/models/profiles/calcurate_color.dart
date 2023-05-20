import 'package:flutter/material.dart';

int calculateLifeNumber(String birthdate) {
  // birthdate format: yyyy/mm/dd
  List<String> birthdateParts = birthdate.split('/');

  // calculate the sum of all digits
  int sum = 0;
  for (String part in birthdateParts) {
    for (int i = 0; i < part.length; i++) {
      sum += int.parse(part[i]);
    }
  }

  if (sum == 33 || sum == 22 || sum == 11) {
    return sum;
  } else {
    while (sum > 9) {
      int temp = sum;
      sum = 0; //sumの再初期化
      while (temp != 0) {
        sum += temp % 10;
        temp ~/= 10;
      }
      if (sum == 11) {
        return sum;
      }
    }
    return sum;
  }
}

Color calculateColor(String birthdate) {
  int lifeNumber = calculateLifeNumber(birthdate);

  switch (lifeNumber) {
    case 33:
      return Colors.black38;
    case 22:
      return Colors.greenAccent;
    case 11:
      return Colors.blueAccent;
    case 9:
      return Colors.pinkAccent;
    case 8:
      return Colors.orange;
    case 7:
      return Colors.purple;
    case 6:
      return Colors.pink;
    case 5:
      return Colors.lightBlue;
    case 4:
      return Colors.green;
    case 3:
      return Colors.yellow;
    case 2:
      return Colors.blue;
    case 1:
      return Colors.red;
    default:
      return Colors.orange;
  }
}
