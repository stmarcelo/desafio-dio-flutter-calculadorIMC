import 'package:calculadora_imc/model/settings_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  static SharedPreferences? _sharedPrefs;

  SettingsRepository._();

  static Future<SettingsRepository> getInstance() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
    return SettingsRepository._();
  }

  SettingsModel get() {
    var model = SettingsModel();
    model.userName = _sharedPrefs!.getString("settings_userName") ?? "";
    model.stature = _sharedPrefs!.getDouble("settings_stature") ?? 0;
    debugPrint(model.toString());
    return model;
  }

  void set(SettingsModel model) {
    debugPrint(model.toString());
    _sharedPrefs!.setString("settings_userName", model.userName);
    _sharedPrefs!.setDouble("settings_stature", model.stature);
  }
}
