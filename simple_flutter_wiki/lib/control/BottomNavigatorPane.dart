import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/control/NewPageFormular.dart';

import 'ListViewFlutterPage.dart';

class BottomNavigationPane extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigationPane> {
  int currentScreenIndex = 0;
  List<Widget> screens = [FlutterPageListView(), NewPageFormular()];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 55.0,
        child: BottomAppBar(
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  onOpenHome(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.blur_on, color: Colors.white),
                onPressed: () {
                  onOpenNewPageFormular(context);
                },
              )
            ],
          ),
        ));
  }

  void onOpenHome(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => FlutterPageListView()));
  }

  void onOpenNewPageFormular(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewPageFormular()));
  }
}
