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

  String _colorCondition = '';
  String get colorCondition => _colorCondition;
  set colorCondition(String value) {
    _colorCondition = value;
  }

  double _blurredImageBytes = 0.0;
  double get blurredImageBytes => _blurredImageBytes;
  set blurredImageBytes(double value) {
    _blurredImageBytes = value;
  }

  String _filteredImage = '';
  String get filteredImage => _filteredImage;
  set filteredImage(String value) {
    _filteredImage = value;
  }

  int _totalRed = 0;
  int get totalRed => _totalRed;
  set totalRed(int value) {
    _totalRed = value;
  }

  int _totalGreen = 0;
  int get totalGreen => _totalGreen;
  set totalGreen(int value) {
    _totalGreen = value;
  }

  int _totalBlue = 0;
  int get totalBlue => _totalBlue;
  set totalBlue(int value) {
    _totalBlue = value;
  }

  int _pixelCount = 0;
  int get pixelCount => _pixelCount;
  set pixelCount(int value) {
    _pixelCount = value;
  }

  String _processedImageBytes = '';
  String get processedImageBytes => _processedImageBytes;
  set processedImageBytes(String value) {
    _processedImageBytes = value;
  }

  String _processedImageBase64 = '';
  String get processedImageBase64 => _processedImageBase64;
  set processedImageBase64(String value) {
    _processedImageBase64 = value;
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
