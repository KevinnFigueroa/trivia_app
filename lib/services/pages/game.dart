import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/controllers/backend_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:trivia_app/models/game.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final separator = SizedBox(height: 15);
  int listOfWords;
  List<dynamic> words;
  TextEditingController textEditingController;
  String currentWordEditing;
  int wordRoundLength;
  bool _showInput = false;

  Map roundResult;
  int corrects = 0;
  int incorrects = 0;

  String wordInRound;
  String definitionInRound;
  Timer _count;
  int currentIndexRound = 0;

  int countMarker = 30;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditingController.dispose();
    _count?.cancel();
    super.dispose();
  }

  void timer() {
    setState(() {
      _showInput = true;
    });
    initialWord();
    _count = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countMarker == 0) {
        nextWord();
      }
      countMarker -= 1;
    });
  }

  void nextWord() {
    currentIndexRound += 1;

    setState(() {
      countMarker = 30;
    });
  }

  void initialWord() {
    GameModel().newWord(
        wordInRound, wordRoundLength, corrects, incorrects, currentIndexRound);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: randomTrivia(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          print("${snapshot.data}");
          words = snapshot.data;
          listOfWords = words.length;
          GameModel().initialData(listOfWords);
          // words.forEach((value) {
          //   print("VALORES EN EL JSON :$value");
          // });
          return ListView(
            children: [
              SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        //changePage(0);
                      },
                      heroTag: null,
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      label: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Cancelar ronda",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: HexColor("#4285f4"),
                    )
                  ],
                ),
              ),
              separator,
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.5),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Correctas: $corrects",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              color: Colors.pink.withOpacity(0.5),
                              shape: BoxShape.circle),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Incorrectas: $incorrects",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Text(
                              "Ronda de $listOfWords definiciones",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Tiempo Restante: ",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Text(
                          "$countMarker s ",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              separator,
              Card(
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Definición",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w400,
                            fontSize: 25,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(5),
                        elevation: 5,
                        color: HexColor("#4285f4"),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Presione jugar para comenzar a adivinar palabras",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  height: 20,
                  thickness: 0.5,
                  color: Colors.grey[300],
                ),
              ),
              Card(
                margin: const EdgeInsets.all(15),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _showInput
                              ? PinCodeTextField(
                                  length: wordRoundLength,
                                  obscureText: false,
                                  animationType: AnimationType.fade,
                                  pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.white,
                                  ),
                                  animationDuration:
                                      Duration(milliseconds: 300),
                                  backgroundColor: Colors.blue.shade50,
                                  enableActiveFill: true,
                                  //errorAnimationController: errorController,
                                  controller: textEditingController,
                                  onCompleted: (v) {
                                    print("Completed");
                                    if (v == wordInRound) {
                                      corrects += 1;
                                    } else {
                                      incorrects += 1;
                                    }
                                  },
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      currentWordEditing = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {
                                    print("Allowing to paste $text");
                                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                    return true;
                                  },
                                )
                              : Container()
                        ],
                      ),
                      separator,
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              height: 50,
                              color: HexColor("#4285f4"),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "Jugar",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                timer();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
