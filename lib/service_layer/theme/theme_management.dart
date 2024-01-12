import 'package:flutter/foundation.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';
import 'package:kindergarden_mobile/service_layer/shared_preferences/shared_preference_enums.dart';
import 'package:kindergarden_mobile/service_layer/shared_preferences/shared_preferences.dart';
import 'package:kindergarden_mobile/service_layer/theme/base/theme.dart';
import 'package:kindergarden_mobile/service_layer/theme/dark/theme.dart';
import 'package:kindergarden_mobile/service_layer/theme/light/theme.dart';

// ignore: constant_identifier_names
enum ThemeState { Light, Dark }

class ThemeManagement with ChangeNotifier {
  static final ThemeManagement include = ThemeManagement();

  ThemeState _state = ThemeState.Light;
  ThemeState get state => _state;

  BaseTheme get theme => _state == ThemeState.Light ? LightTheme() : DarkTheme();

  BaseTheme get reverseTheme => _state == ThemeState.Light ? DarkTheme() : LightTheme();

  set state(ThemeState value) {
    _state = value;

    notifyListeners();
  }

  Future changeTheme({ThemeState? themeState}) async {
    _state = themeState ?? (_state == ThemeState.Light ? ThemeState.Dark : ThemeState.Light);
    Logger.instance.log('ThemeManagement ::: changeTheme ::: ${_state.toString()} :: ${SharedPreferenceEnum.themeStatePref.toString()}');
    await SharedPreferencesService.instance.setString(key: SharedPreferenceEnum.themeStatePref.toString(), value: _state.toString());

    notifyListeners();
  }

  Future syncTheme() async {
    String? themeState = await SharedPreferencesService.instance.getString(key: SharedPreferenceEnum.themeStatePref.toString());
    if (themeState == ThemeState.Light.toString()) {
      _state = ThemeState.Light;
    } else if (themeState == ThemeState.Dark.toString()) {
      _state = ThemeState.Dark;
    } else {
      _state = ThemeState.Dark;
    }

    Logger.instance.log('ThemeManagement ::: syncTheme ::: ${themeState.toString()} :: $_state');
    notifyListeners();
  }
}
