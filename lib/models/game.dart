import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GameModel extends ChangeNotifier {
  int corrects = 0;
  int incorrects = 0;
  String wordInRound;
  int wordsInRoundLength;
  int listOfWords;
  int currentIndexRound = 0;
  bool roundFinalizated = false;

  bool stateRound = false;

  void initialData(listOfWords) {
    this.listOfWords = listOfWords;
  }

  void newWord(wordInRound, wordsInRoundLength, corrects, incorrects,
      currentIndexRound) {
    this.wordInRound = wordInRound;
    this.wordsInRoundLength = wordsInRoundLength;
    this.corrects = corrects;
    this.incorrects = incorrects;
    this.currentIndexRound = currentIndexRound;

    if (currentIndexRound == listOfWords + 1) {
      this.roundFinalizated = true;
    }
    notifyListeners();
  }

  void startRound() {
    this.stateRound = true;
    notifyListeners();
  }

  void finishRound() {
    this.stateRound = false;
    notifyListeners();
  }
}
