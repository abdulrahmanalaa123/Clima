class NoAccess implements Exception {
  String message =
      'you have no access to the internet or to the API Call right now try again';

  @override
  String toString() {
    return message;
  }
}
