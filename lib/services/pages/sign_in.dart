import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

//COLOR DE FONDO: #0d0c22
//COLOR DE BOTON : #4285f4

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    const separator = SizedBox(height: 15);

    return Scaffold(
      /*appBar: AppBar(
        actions: [],
        // centerTitle: true,
        backgroundColor: Colors.transparent,
        //backgroundColor: Colors.black.withOpacity(0.8),
        toolbarHeight: 150,
        //toolbarHeight: MediaQuery.of(context).size.height / 3.5,
        title: ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            padding: EdgeInsets.all(0),
            height: 120,
            width: double.infinity,
            color: Colors.orange,
            child: Center(child: Text("")),
          ),
        ),*/
      /*Column(
          children: [
            Container(
                height: 60,
                width: 60,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: Icon(Icons.wb_incandescent_rounded,
                    color: Colors.black.withOpacity(0.8))),
            separator,
            Text(
              "Trivia app",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),*/
      //),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white70,
        child: Stack(children: [
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 115,
              width: double.infinity,
              color: HexColor("#4285f4"),
              child: Center(child: Text("")),
            ),
          ),
          Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        //margin: EdgeInsets.only(bottom: 40),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Bienvenido a trivia App",
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
                                  "Sé el mejor en trivias",
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
                    SizedBox(height: 20),
                    Card(
                      margin: const EdgeInsets.all(15),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Inicia sesión",
                                  style: GoogleFonts.ubuntu(
                                    textStyle: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            separator,
                            Container(
                              child: Column(
                                children: [
                                  TextField(
                                      controller: null,
                                      decoration: InputDecoration(
                                          hintText: "Usuario",
                                          suffixIcon: Icon(
                                              Icons.supervised_user_circle))),
                                  separator,
                                  TextField(
                                      controller: null,
                                      decoration: InputDecoration(
                                          hintText: "Contraseña",
                                          suffixIcon:
                                              Icon(Icons.privacy_tip_rounded))),
                                  separator,
                                  separator,
                                  Row(
                                    children: [
                                      Expanded(
                                        child: MaterialButton(
                                          height: 50,
                                          color: HexColor("#4285f4"),
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "Iniciar sesión",
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
                            separator,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SignInButton(
                                  Buttons.GoogleDark,
                                  elevation: 5,
                                  text: "Inicia sesión con Google",
                                  onPressed: () async {
                                    await authService.googleSignIn();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                /*Expanded(
                  child: Card(
                    margin: const EdgeInsets.all(20),
                    elevation: 10,
                    //color: Colors.red,
                    //height: MediaQuery.of(context).size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Inicia sesión",
                                style: GoogleFonts.ubuntu(
                                  textStyle: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Column(
                              children: [
                                TextField(
                                  controller: null,
                                  decoration:
                                      InputDecoration(hintText: "Usuario"),
                                ),
                                separator,
                                TextField(
                                  controller: null,
                                  decoration:
                                      InputDecoration(hintText: "Contraseña"),
                                ),
                                separator,
                                separator,
                                Row(
                                  children: [
                                    Expanded(
                                      child: MaterialButton(
                                        height: 50,
                                        //minWidth:
                                        //    MediaQuery.of(context).size.width / 1.2,
                                        color: HexColor("#4285f4"),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Iniciar sesión",
                                          style: GoogleFonts.ubuntu(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await authService.googleSignIn();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SignInButton(
                                Buttons.GoogleDark,
                                elevation: 5,
                                text: "Inicia sesión con google",
                                onPressed: () async {
                                  await authService.googleSignIn();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),*/
              ]),
        ]),
      ),
    );
  }
}
