import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_app/services/auth.dart';
import 'package:trivia_app/utils/loading_screen.dart';

import 'models/game.dart';
import 'services/pages/home.dart';
import 'services/pages/sign_in.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AuthService>(
      create: (_) => AuthService.instance(),
    ),
    ChangeNotifierProvider<GameModel>(create: (_) => GameModel())
  ], child: App()));
}

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

//TODO agregar provider aqui
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // Rutas
      },
      debugShowCheckedModeBanner: false,
      title: 'Trivia app',
      home: Consumer(
        builder: (context, AuthService authService, _) {
          switch (authService.status) {
            case AuthStatus.Uninitialized:
              return LoadingScreen();
            case AuthStatus.Authenticated:
              return Home();
            case AuthStatus.Authenticating:
              return SignIn();
            case AuthStatus.Unauthenticated:
              return SignIn();
          }
          return null;
        },
      ),
    );
  }
}
