import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _colorir = prefs.getString('ff_colorir') ?? _colorir;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _colorir = '';
  String get colorir => _colorir;
  set colorir(String value) {
    _colorir = value;
    prefs.setString('ff_colorir', value);
  }

  int _red = 0;
  int get red => _red;
  set red(int value) {
    _red = value;
  }

  int _green = 1;
  int get green => _green;
  set green(int value) {
    _green = value;
  }

  int _blue = 2;
  int get blue => _blue;
  set blue(int value) {
    _blue = value;
  }

  String _ImagePath = '';
  String get ImagePath => _ImagePath;
  set ImagePath(String value) {
    _ImagePath = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
