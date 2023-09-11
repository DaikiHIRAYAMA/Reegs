// ignore: file_names
import 'package:reegs/models/register/Enneagram_model.dart';

class EnneagramViewModel {
  final EnneagramModel model;

  EnneagramViewModel(this.model);

  String get description => model.description;
  String get detailedDescription => model.detailedDescription;
}
