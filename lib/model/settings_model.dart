// ignore_for_file: unnecessary_getters_setters

class SettingsModel {
  String _userName = "";
  double _stature = 0;

  SettingsModel();

  String get userName => _userName;
  set userName(String value) => _userName = value;

  double get stature => _stature;
  set stature(double value) => _stature = value;

  @override
  String toString() {
    return "userName: $_userName, stature: $_stature";
  }
}
