import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:trivia_app/utils/constants.dart';

Future<dynamic> randomTrivia() async {
  try {
    print("llegue 1");
    var response = await http.get(
      BACKEND_URL + "random_trivia",
    );

    return json.decode(response.body);
    // in case of the exception, show snackBar and return null
  } on SocketException {
    print('No Internet connection 😑');
    return null;
  } on HttpException {
    print("Couldn't find the post 😱");
    return null;
  } on FormatException {
    print("Bad response format 👎");
    return null;
  }
}
