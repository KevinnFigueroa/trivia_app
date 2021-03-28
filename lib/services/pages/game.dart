import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:trivia_app/controllers/backend_controller.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final separator = SizedBox(height: 15);
  int words_length;
  List<dynamic> words;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: randomTrivia(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          print("${snapshot.data}");
          words = snapshot.data;
          words_length = words.length;

          words.forEach((value) {
            print("VALORES EN EL JSON :$value");
          });

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
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Row(
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
                      "30 s ",
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
                  height: 40,
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
                          Text(
                            "Rayitas con digitos",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                letterSpacing: 0,
                              ),
                            ),
                          )
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
                              onPressed: () async {},
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
