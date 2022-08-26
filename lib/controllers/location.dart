import 'package:geocoding/geocoding.dart';
import 'package:lpg_agency_locator/views/signUpScreen/signup_screen.dart';
import 'package:location/location.dart' as lt;

class UserLocation {
  static double lat = 0.0;
  static double long = 0.0;
}

Future<void> getLocation() async {
  List<Placemark> placemark =
      await placemarkFromCoordinates(UserLocation.lat, UserLocation.long);

  country = placemark[0].country!;
  name = placemark[0].subLocality!;
  city = placemark[0].locality!;
  subArea = placemark[0].subAdministrativeArea!;
  area = placemark[0].administrativeArea!;
  postalCode = placemark[0].postalCode!;
}

Future<void> locationService() async {
  lt.Location location = lt.Location();

  bool _serviceEnabled;
  lt.PermissionStatus _permissionLocation;
  lt.LocationData _locData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionLocation = await location.hasPermission();
  if (_permissionLocation == lt.PermissionStatus.denied) {
    _permissionLocation = await location.requestPermission();
    if (_permissionLocation != lt.PermissionStatus.granted) {
      return;
    }
  }

  _locData = await location.getLocation();

  UserLocation.lat = _locData.latitude!;
  UserLocation.long = _locData.longitude!;

  getLocation();
}
