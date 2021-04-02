import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/controllers/backend_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:toast/toast.dart';
import 'package:trivia_app/models/game.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

//TODO: agregar provider en el main

class _GameState extends State<Game> with TickerProviderStateMixin {
  final separator = SizedBox(height: 15);
  int listOfWords;
  List<dynamic> words;
  PageController _pageWordController = PageController();
  TextEditingController textEditingController = TextEditingController();
  String currentWordEditing;
  int wordRoundLength;

  Map roundResult;
  int corrects = 0;
  int incorrects = 0;

  String wordInRound;
  String definitionInRound;
  Timer _count;
  int currentIndexRound = 0;

  int countMarker = 30;

  bool _startRound = false;

  AnimationController _controller;

  Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 5000),
        vsync: this,
        value: 0,
        lowerBound: 0,
        upperBound: 1);

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.forward();
    super.initState();
  }

  /*@override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
    textEditingController.dispose();
    _count?.cancel();
  }*/

  void timer() {
    //setState(() {
    //  _showInput = true;
    //});
    initialWord();
    _count = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countMarker == 0) {}
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
    GameModel().newWord(wordInRound, wordRoundLength, corrects, incorrects);
  }

  @override
  Widget build(BuildContext context) {
    GameModel gameProvider = Provider.of<GameModel>(context, listen: false);
    words = gameProvider.words;
    listOfWords = gameProvider.listOfWords;
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
                  Consumer<GameModel>(
                    builder: (context, value, child) {
                      return Text(
                        "${countMarker} s ",
                        style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            letterSpacing: 1,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        separator,
        Consumer<GameModel>(builder: (context, value, child) {
          if (value.stateRound) {
            return FadeTransition(
              opacity: _animation,
              child: SizedBox(
                height: 180,
                child: PageView(
                  scrollDirection: Axis.vertical,
                  controller: _pageWordController,
                  children: [
                    for (var word in words)
                      Card(
                        margin: const EdgeInsets.all(15),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                ],
                              ),
                              SizedBox(height: 10),
                              Card(
                                margin: const EdgeInsets.all(5),
                                elevation: 5,
                                color: HexColor("#4285f4"),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${word['definitions'][0]}",
                                        //"${words[currentIndexRound]['definitions'][0]}",
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
                      )
                  ],
                ),
              ),
            );
          } else {
            return Card(
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
            );
          }
        }),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Divider(
            height: 20,
            thickness: 0.5,
            color: Colors.grey[300],
          ),
        ),
        /*_startRound
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PinCodeTextField(
                              appContext: context,
                              //cursorHeight: 60,
                              //cursorWidth:
                              //    MediaQuery.of(context).size.width / 1.2,
                              length: wordRoundLength,
                              obscureText: false,
                              //TODO:
                              //validator: ,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                              ),
                              animationDuration: Duration(milliseconds: 300),
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
                          ],
                        )
                      : Container(),*/
        Card(
          margin: const EdgeInsets.all(15),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                separator,
                Consumer<GameModel>(builder: (context, value, child) {
                  if (value.stateRound) {
                    print("ENTRE EN ROUND TRUE");
                    //GameModel stateProvider =
                    //    Provider.of<GameModel>(context, listen: false);
                    //stateProvider.stateRound = false;
                    return Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            height: 50,
                            color: HexColor("#4285f4"),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Enviar respuesta",
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
                              //TODO: ver que hacer en la ultima palabra, llamar a Gamemodel().finishRound();
                              Toast.show("Correcta", context,
                                  duration: Toast.LENGTH_SHORT,
                                  gravity: Toast.CENTER);
                              currentIndexRound += 1;
                              wordInRound =
                                  words[currentIndexRound]["word"].toString();
                              //setState(() {
                              wordRoundLength = words[currentIndexRound]["word"]
                                  .toString()
                                  .length;

                              _pageWordController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.fastOutSlowIn,
                              );
                              //});
                              //timer();
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    print("ENTRE EN ROUND FALSE");
                    return Row(
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
                              //TODO: ver que hacer en la ultima palabra
                              wordInRound =
                                  words[currentIndexRound]["word"].toString();
                              //setState(() {
                              wordRoundLength = words[currentIndexRound]["word"]
                                  .toString()
                                  .length;
                              //});
                              gameProvider.startRound();
                              //timer();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
