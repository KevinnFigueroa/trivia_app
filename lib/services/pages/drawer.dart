/*import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

var imageFile;

class Drawers {
  stylishDrawer(BuildContext context) {
    return ClipPath(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF26D4A6), Color(0xFF26D4A6)])),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            /*BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                  decoration: BoxDecoration(
                color: Color(0xFF26D4A6),
              )
                  /*gradient: LinearGradient(
                    colors: <Color>[
                      //Colors.cyan[800],
                      Color(0xFF26D4A6),
                    ],
                  ),
                ),*/
                  ),
            ),*/
            /*Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.7),
              //color: Color(0xFF26D4A6).withOpacity(0.1),
            ),*/
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.6,
              padding: EdgeInsets.only(top: 30, bottom: 10),
              color: Colors.white,
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    context.watch<UltraAppModel>().fileImageUltraman == null
                        ? Icon(FontAwesomeIcons.solidUserCircle,
                            size: 100, color: Colors.black.withOpacity(0.7))
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(imageFile),
                                          fit: BoxFit.fitWidth)),
                                ),
                                
          
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.watch<UltraAppModel>().userName != null
                                ? context.watch<UltraAppModel>().userName
                                : "",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "5.2",
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                FontAwesomeIcons.solidStar,
                                size: 25,
                                color: Colors.amber,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    //const SizedBox(height: 20),

                    /*Divider(
                      height: 0.5,
                      color: Colors.white,
                    ),*/
                    _drawerWidget(
                      context,
                      "drawer.transactions",
                      FontAwesomeIcons.listAlt,
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.white,
                    ),
                    _drawerWidget(
                      context,
                      "drawer.log_out",
                      FontAwesomeIcons.signOutAlt,
                    ),
                    Divider(
                      height: 0.5,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/logo3.png",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //TODO: cuando presiono en cerrar sesión, debo poner en modo offline antes al ultraman.

  //Menu_Lateral
  _drawerWidget(BuildContext context, title, icon) {
    return ListTile(
      onTap: () {
        switch (title) {
          case "drawer.home":
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (Route<dynamic> route) => false);
            break;

          case "drawer.log_out":
            logOut().then((value) {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  CupertinoPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (Route<dynamic> route) => false);
            });
            break;

          case "drawer.transactions":
            //TODO: redirigir a nueva pantalla de transacciones
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => TransactionScreen(),
              ),
            );
            break;

          default:
            break;
        }
      },
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        "$title".tr(),
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}*/
