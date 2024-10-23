// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io'; // Para dispositivos móveis
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart'; // Para seleção de imagens
import 'package:flutter/foundation.dart'; // Necessário para usar kIsWeb
import 'dart:html' as html; // Necessário apenas para Flutter Web

Future<void> handleImageSelection() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile == null) {
    print('Nenhuma imagem foi selecionada.');
    return; // Retorna se nenhuma imagem for selecionada
  }

  Uint8List imageBytes;

  // Verifica se está rodando na Web
  if (kIsWeb) {
    // Para Web, usa FileReader e converte XFile para Uint8List diretamente
    imageBytes = await pickedFile.readAsBytes();
  } else {
    // Para dispositivos móveis e desktop
    File imageFile = File(pickedFile.path);
    imageBytes = await imageFile.readAsBytes();
  }

  // Decodifica a imagem usando o pacote image
  img.Image? image = img.decodeImage(imageBytes);

  if (image == null) {
    print('Erro ao carregar a imagem.');
    return;
  }

  // Captura o pixel do centro da imagem
  int x = (image.width / 2).round();
  int y = (image.height / 2).round();
  img.Pixel pixel = image.getPixel(x, y);

  // Exibe os valores RGB no console
  print(
      'Valores RGB no centro da imagem: Red = ${pixel.r}, Green = ${pixel.g}, Blue = ${pixel.b}');

  // Atualiza o FFAppState com os valores RGB
  FFAppState().red = pixel.r.toInt();
  FFAppState().green = pixel.g.toInt();
  FFAppState().blue = pixel.b.toInt();

  // Atualiza o caminho da imagem no App State para exibir a imagem
  if (kIsWeb) {
    FFAppState().ImagePath = pickedFile.path;
  } else {
    FFAppState().ImagePath = pickedFile.path;
  }
}
