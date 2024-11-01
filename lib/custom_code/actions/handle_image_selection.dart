// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io' as io; // Para dispositivos móveis
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart'; // Para seleção de imagens
import 'package:flutter/foundation.dart'; // Necessário para usar kIsWeb

// A importação de 'dart:html' é removida para evitar erros em compilações móveis
// Somente utilize funcionalidades de Web quando kIsWeb for verdadeiro

Future<void> handleImageSelection(BuildContext context) async {
  final picker = ImagePicker();

  // Diálogo para escolher a fonte da imagem
  ImageSource? source = await showDialog<ImageSource>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Selecionar fonte da imagem'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            child: Text('Câmera'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            child: Text('Galeria'),
          ),
        ],
      );
    },
  );

  // Se o usuário cancelar o diálogo, não continue
  if (source == null) {
    print('Nenhuma fonte selecionada.');
    return;
  }

  final pickedFile = await picker.pickImage(source: source);

  if (pickedFile == null) {
    print('Nenhuma imagem foi selecionada.');
    return; // Retorna se nenhuma imagem for selecionada
  }

  Uint8List imageBytes;

  if (kIsWeb) {
    imageBytes = await pickedFile.readAsBytes();
    // Processamento para Web
  } else {
    final imageFile = io.File(pickedFile.path);
    imageBytes = await imageFile.readAsBytes();
    // Processamento para dispositivos móveis
  }

  // Decodifica a imagem usando o pacote image
  img.Image? image = img.decodeImage(imageBytes);

  if (image == null) {
    print('Erro ao carregar a imagem.');
    return;
  }

  // Aplica suavização na imagem
  image = img.gaussianBlur(image, radius: 5); // Define o raio do desfoque

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
  FFAppState().ImagePath = pickedFile.path;

  // Avalia a condição com base nos valores RGB e armazena o resultado
  FFAppState().colorCondition =
      avaliarCor(FFAppState().red, FFAppState().green, FFAppState().blue);
}

// Função para avaliar a cor com base nos valores RGB
String avaliarCor(int red, int green, int blue) {
  if (red <= 177 && green > 80 && green < 92 && blue <= 1) {
    return 'Egg 1: A cor da gema é predominante alaranjada-avermelhada.';
  } else if (red > 176 && green < 120 && blue == 0) {
    return 'Egg 2: A cor é da gema é predominante laranja-amarelada.';
  } else if (red >= 200 && green > 135 && blue > -1 && blue < 10) {
    return 'Egg 3: A cor da gema é predominante amarelo-palido.';
  } else if (red >= 160 && green >= 110 && blue >= 0) {
    return 'Egg 4: A cor da gema é predominante palida';
  } else {
    return 'A cor é equilibrada ou mista.';
  }
}

@override
Widget build(BuildContext context) {
  // Pega os valores RGB e a condição do AppState
  final int red = FFAppState().red;
  final int green = FFAppState().green;
  final int blue = FFAppState().blue;
  final String colorCondition =
      FFAppState().colorCondition ?? 'Nenhuma avaliação realizada.';

  return Scaffold(
    appBar: AppBar(
      title: Text('Análise de Cor'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Mostra a imagem selecionada, se houver
          FFAppState().ImagePath != null
              ? Image.file(io.File(FFAppState().ImagePath))
              : Text('Nenhuma imagem selecionada.'),

          // Mostra o resultado da condição baseada nos valores RGB
          Text(
            colorCondition,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    ),
  );
}
