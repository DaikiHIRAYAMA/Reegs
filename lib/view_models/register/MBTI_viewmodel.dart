// ignore: file_names
import 'package:reegs/models/register/MBTI_model.dart';

class MBTIViewModel {
  final MBTIModel model;

  MBTIViewModel(this.model);

  String get description => model.description;
  String get detailedDescription => model.detailedDescription;
}
