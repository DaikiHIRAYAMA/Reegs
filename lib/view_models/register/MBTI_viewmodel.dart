// ignore: file_names
import 'package:reegs/models/register/MBTImodel.dart';

class MBTIViewModel {
  final MBTIModel model;

  MBTIViewModel(this.model);

  String get description => model.description;
}
