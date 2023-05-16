import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:reegs/view_models/profiles/profile_viewmodel.dart';

Future<Position> getPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}

class User {
  final Position position;
  User(this.position);
}

double calculateDistance(Position pos1, Position pos2) {
  Distance distance = Distance();

  // メートル単位で距離を計算
  return distance(
    LatLng(pos1.latitude, pos1.longitude),
    LatLng(pos2.latitude, pos2.longitude),
  ).toDouble();
}

void calculateDistances(Position myPosition, List<User> allUsers) {
  for (var user in allUsers) {
    double distance = calculateDistance(myPosition, user.position);
    print("The distance between me and the user is $distance meters.");
  }
}
