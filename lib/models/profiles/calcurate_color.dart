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
      return Colors.white;
    case 22:
      return Colors.blue;
    case 11:
      return Colors.white;
    case 9:
      return Colors.white;
    case 8:
      return Colors.white;
    case 7:
      return Colors.white;
    case 6:
      return Colors.white;
    case 5:
      return Colors.white;
    case 4:
      return Colors.white;
    case 3:
      return Colors.white;
    case 2:
      return Colors.white;
    case 1:
      return Colors.white;
    default:
      return Colors.orange;
  }
}
