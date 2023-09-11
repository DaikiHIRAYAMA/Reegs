// ignore: file_names
import 'package:reegs/models/register/mbti_text_model.dart';

class MBTIViewModel {
  final MBTIModel model;

  MBTIViewModel(this.model);

  String get description => model.description;
  String get detailedDescription => model.detailedDescription;
}
