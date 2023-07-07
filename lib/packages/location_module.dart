import 'package:location/location.dart';
import 'location_errors.dart';

class Position {
  double? latitude;
  double? longitude;
  bool _serviceEnabled = false;
  Location location = Location();
  PermissionStatus? _permissionStatus;
  LocationData? _locationData;
  LocationAccuracy locationAccuracy = LocationAccuracy.low;
  //takes alot of memory and skips frames how can i solve?
  void requestAccess() {
    _requestLocationService();
    _requestPermissionLocation();
  }

  void _requestLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    if (!_serviceEnabled) {
      throw ServiceNotProvided();
    }
  }

  void _requestPermissionLocation() async {
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus != PermissionStatus.granted) {
      _permissionStatus = await location.requestPermission();
    }
    if (_permissionStatus != PermissionStatus.granted) {
      throw PermissionNotProvided();
    }
  }

  void init() async {
    _locationData = await location.getLocation();
    print(_locationData);
    // nullability applied because of context it shouldnt be a problem since it
    //wont reach unless it pass the request service
    latitude = _locationData?.latitude;
    longitude = _locationData?.longitude;
  }
}
