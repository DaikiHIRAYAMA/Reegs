// models/user.dart
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

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
