import 'dart:math';

import 'package:flutter_tts/flutter_tts.dart';

class AuditoryInput {
  late String letter;
  AuditoryInput() {
    letter = possibleLetters[new Random().nextInt(possibleLetters.length)];
  }

  List<String> possibleLetters = ["s", "q", "l", "t", "k", "r", "o"];
  static FlutterTts tts = new FlutterTts();

  speak() {
    tts.speak(letter);
  }
}
