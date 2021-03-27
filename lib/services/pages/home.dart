import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:trivia_app/services/auth.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final separator = SizedBox(height: 15);
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    //logger = Logger();
    //logger.i("entra a INITSTATE");
    _pageController = PageController();
  }

  Widget _letsPlay() {
    return ListView(
      children: [
        SizedBox(height: 100),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        changePage(0);
                      },
                      heroTag: null,
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      label: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Volver",
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
                separator,
                Row(
                  children: [
                    Text(
                      "Comenzar a jugar",
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
                separator,
                Row(
                  children: [
                    Text(
                      "Selecciona modo",
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.all(15),
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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

  void changePage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
    );
  }

  Widget _home() {
    return ListView(
      children: [
        SizedBox(height: 100),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Mi perfil",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                              fontSize: 30,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            changePage(1);
                          },
                          heroTag: null,
                          icon: Icon(FontAwesomeIcons.dice),
                          label: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Jugar",
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.all(15),
              elevation: 10,
              color: HexColor("#4285f4"),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: Colors.white,
                          size: 40,
                        ),
                        Text(
                          "Kevin Figueroa",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "5.2",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(FontAwesomeIcons.solidStar,
                                color: Colors.amber)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Ranking",
                            style: GoogleFonts.ubuntu(
                              textStyle: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    separator,
                    Row(
                      children: [
                        Text(
                          "Top 5 mejores jugadores",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              margin: const EdgeInsets.all(15),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: Colors.black87,
                          size: 35,
                        ),
                        Text(
                          "Armando contreras",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "3.2",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(FontAwesomeIcons.solidStar,
                                color: Colors.amber)
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.8,
                      color: Colors.grey[300],
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: Colors.black87,
                          size: 35,
                        ),
                        Text(
                          "Renzo Robles",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "3.1",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(FontAwesomeIcons.solidStar,
                                color: Colors.amber)
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.8,
                      color: Colors.grey[300],
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: Colors.black87,
                          size: 35,
                        ),
                        Text(
                          "Germán zamudio",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "2.9",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(FontAwesomeIcons.solidStar,
                                color: Colors.amber)
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.8,
                      color: Colors.grey[300],
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          FontAwesomeIcons.solidUserCircle,
                          color: Colors.black87,
                          size: 35,
                        ),
                        Text(
                          "Pablo fernandez",
                          style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 1,
                            ),
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "2.6",
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(FontAwesomeIcons.solidStar,
                                color: Colors.amber)
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
/*MaterialButton(
          child: Text('Cerrar Sesión ${authService.user.displayName}'),
          onPressed: () {
            authService.signOut();
          },
        )*/
    final authService = Provider.of<AuthService>(context);

    //TODO: ESTE SCAFFOLD TIENE QUE SER UN FUTUREBUILDER Y CONSULTAR DATOS INICIALES AL BACKEND
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Stack(
          children: [
            ClipPath(
              clipper: WaveClipperTwo(),
              child: Container(
                height: 115,
                width: double.infinity,
                color: HexColor("#4285f4"),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(FontAwesomeIcons.bars,
                                color: Colors.black87),
                          ))
                    ],
                  ),
                ),
              ),
            ),
            PageView(
              controller: _pageController,
              children: [_home(), _letsPlay()],
            )
          ],
        ),
      ),
    );
  }
}
