import 'package:reegs/models/register/soc_text_model.dart';

class SociopathViewModel {
  final SociopathModel model;

  SociopathViewModel(this.model);

  String get description => model.description;
}
