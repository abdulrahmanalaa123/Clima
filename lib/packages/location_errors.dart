class ServiceNotProvided implements Exception {
  final String _errorString =
      'Service Not Provided, Cant start Application without Location service';

  @override
  String toString() {
    return _errorString;
  }
}

class PermissionNotProvided implements Exception {
  final String _errorString =
      'You need to grant The Application Access to Your Location';
  @override
  String toString() {
    return _errorString;
  }
}
