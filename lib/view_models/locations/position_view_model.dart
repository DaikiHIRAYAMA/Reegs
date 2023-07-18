import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:reegs/models/profiles/user_model.dart';

final positionViewModelProvider =
    ChangeNotifierProvider((ref) => PositionViewModel());

class PositionViewModel with ChangeNotifier {
  double? _distance = 0;

  double get distance {
    assert(_distance != null, 'Distance was null when accessed.');
    return _distance!;
  }

  set distance(double value) {
    _distance = value;
    notifyListeners();
  }

  //TODO:Userを友達一覧に変更する
  void calculateAndNotifyDistances(Position myPosition, List<User> allUsers) {
    for (var user in allUsers) {
      double distance = calculateDistance(myPosition, user.position);
      print("The distance between me and the user is $distance meters.");
    }
  }
}

// Future<Position> getPosition() async {
//   bool serviceEnabled;
//   LocationPermission permission;

//   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!serviceEnabled) {
//     return Future.error('Location services are disabled.');
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error('Location permissions are denied');
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error(
//         'Location permissions are permanently denied, we cannot request permissions.');
//   }

//   return await Geolocator.getCurrentPosition();
// }
