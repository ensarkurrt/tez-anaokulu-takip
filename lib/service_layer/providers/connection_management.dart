import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum ConnectState { Connected, NotConnected }

class ConnectionManagement with ChangeNotifier {
  static final ConnectionManagement include = ConnectionManagement();

  ConnectState _state = ConnectState.NotConnected;
  ConnectState get state => _state;

  set state(ConnectState value) {
    _state = value;
    notifyListeners();
  }
}
