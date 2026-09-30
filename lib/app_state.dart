import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _buscar = false;
  bool get buscar => _buscar;
  set buscar(bool value) {
    _buscar = value;
  }

  bool _switchTema = false;
  bool get switchTema => _switchTema;
  set switchTema(bool value) {
    _switchTema = value;
  }
}
