import 'package:geolocator/geolocator.dart';

class LocationHelper {
  static Position? locationData;

  static Future<Position> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission _permissionGranted;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    _permissionGranted = await Geolocator.checkPermission();
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (_permissionGranted == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    if (locationData != null) {
      await Future.delayed(const Duration(milliseconds: 100));
      return Future.value(locationData);
    } else {
      var value = await Geolocator.getCurrentPosition();
      locationData = value;
      return value;
    }
  }
}
