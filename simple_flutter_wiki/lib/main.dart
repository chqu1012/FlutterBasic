import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/screen/LoginScreen.dart';

void main() => runApp(FlutterWikiApp());

class FlutterWikiApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter Wiki',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
