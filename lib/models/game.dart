import 'dart:async';

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

  var words;

  void initialData(amountOfWords, wordsToAdivinate) {
    listOfWords = amountOfWords;
    words = wordsToAdivinate;
  }

  void newWord(wordInRound, wordsInRoundLength, corrects, incorrects) {
    this.wordInRound = wordInRound;
    this.wordsInRoundLength = wordsInRoundLength;
    this.corrects = corrects;
    this.incorrects = incorrects;

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

  void changeWord() {
    this.currentIndexRound += 1;
    if (currentIndexRound == listOfWords + 1) {
      this.roundFinalizated = true;
    }
    notifyListeners();
  }
}
