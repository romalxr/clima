import 'package:geolocator/geolocator.dart';
import 'package:huawei_location/huawei_location.dart' as hw;
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' show Platform;

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentPosition() async {
    if (Platform.isAndroid) {
      // Android-specific code
      if (await Permission.locationWhenInUse.request().isGranted) {
        print('azaza Granted');

        final hw.FusedLocationProviderClient _locationService =
            hw.FusedLocationProviderClient();
        final hw.LocationRequest _locationRequest = hw.LocationRequest()
          ..interval = 500;

        try {
          await _locationService.requestLocationUpdates(_locationRequest);
          print('azaza 1');

          final hw.Location location = await _locationService.getLastLocation();

          if (location.latitude == null) {
            print('azaza 3');
            print(location);
          }
          latitude = location.latitude ?? 10;
          longitude = location.longitude ?? 10;
        } on Exception catch (e) {
          print('azaza 2');
          latitude = 10;
          longitude = 10;
          print(e.toString());
        }
      } else {
        print('azaza 4');
        latitude = 10;
        longitude = 10;
      }
    } else if (Platform.isIOS) {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled.');
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print(
            'Location permissions are permanently denied, we cannot request permissions.');
        return;
      }

      try {
        Position position = await Geolocator.getCurrentPosition();
        latitude = position.latitude;
        longitude = position.longitude;
        print('azaza 5');
      } on Exception catch (e) {
        print('azaza 6');
        latitude = 10;
        longitude = 10;
        print(e.toString());
      }
    }
  }
}
