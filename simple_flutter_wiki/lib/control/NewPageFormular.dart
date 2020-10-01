import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'package:simple_flutter_wiki/provider/DBProvider.dart';
import 'package:simple_flutter_wiki/provider/WikiRestProvider.dart';

var bindingTitle = new TextEditingController();
var bindingContent = new TextEditingController();

class NewPageFormular extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(55, 65, 85, 1.0),
        appBar: AppBar(
            elevation: 0.1,
            backgroundColor: Color.fromRGBO(55, 65, 85, 1.0),
            title: Text('New Wiki Page Formular')),
        body: Container(
          padding: EdgeInsets.all(20),
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Text(
                  "Title",
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new TextField(
                  controller: bindingTitle,
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new Text(
                  "Content",
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new TextField(
                  controller: bindingContent,
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new Text(
                  "Category",
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                new DropdownButton<String>(
                  onChanged: popupButtonSelected,
                  value: "Child 1",
                  style: new TextStyle(
                      fontSize: 12.0,
                      color: const Color(0xFF97b8ea),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                  items: <DropdownMenuItem<String>>[
                    const DropdownMenuItem<String>(
                        value: "Child 1", child: const Text("Child 1")),
                    const DropdownMenuItem<String>(
                        value: "Child 2", child: const Text("Child 2")),
                    const DropdownMenuItem<String>(
                        value: "Child 3", child: const Text("Child 3")),
                  ],
                ),
                new RaisedButton(
                    key: null,
                    onPressed: () => buttonPressed(context),
                    color: const Color(0xFFe0e0e0),
                    child: new Text(
                      "Create",
                      style: new TextStyle(
                          fontSize: 12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    )),
              ]),
        ));
  }

  void buttonPressed(BuildContext context) {
    var content = bindingContent.text;
    var title = bindingTitle.text;
    var apiProvider = WikiRestProvider();
    apiProvider.create(title, content);

    var newPage = FlutterPage(title: title, content: content);
    DBProvider.db.insert(newPage);
    Navigator.pop(context);
  }

  void popupButtonSelected(String value) {}
}
