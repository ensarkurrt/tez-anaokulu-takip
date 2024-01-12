// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';

// ignore: constant_identifier_names
enum ViewStateEnum { Idle, Busy }

class StateManagement with ChangeNotifier {
  static final StateManagement include = StateManagement();

  ViewStateEnum _state = ViewStateEnum.Idle;

  String _message = "";

  bool _transparent = true;

  bool _showLoader = true;

  ViewStateEnum get state => _state;

  String get message => _message;

  bool get transparent => _transparent;

  bool get showLoader => _showLoader;

  set state(ViewStateEnum value) {
    _state = value;
    if (value == ViewStateEnum.Idle && !_transparent) {
      _transparent = true;
      _message = "";
    }

    Logger.instance.log('StateManagement ::: state ::: ${_state.toString()}');
    notifyListeners();
  }

  set transparent(bool value) {
    _transparent = value;
  }

  set message(String value) {
    _message = value;
  }

  void changeStateBusy({
    ViewStateEnum stateEnum = ViewStateEnum.Busy,
    String message = "",
    bool transparent = true,
    bool showLoader = true,
  }) {
    _message = message;
    _transparent = transparent;
    _state = stateEnum;
    _showLoader = showLoader;
    notifyListeners();
  }

  void changeStateIdle() {
    _state = ViewStateEnum.Idle;
    _message = "";
    _transparent = true;
    _showLoader = true;
    notifyListeners();
  }
}
