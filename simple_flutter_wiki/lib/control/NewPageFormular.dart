import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/model/FlutterCategory.dart';
import 'package:simple_flutter_wiki/provider/DBProvider.dart';
import 'package:simple_flutter_wiki/provider/WikiRestProvider.dart';

var bindingTitle = new TextEditingController();
var bindingContent = new TextEditingController();
String selectedCategoryId;

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
                FutureBuilder(
                    future: DBProvider.db.findAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return Text(snapshot.error);

                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
                          decoration: new InputDecoration(
                              icon: Icon(
                                  Icons.language)), //, color: Colors.white10
                          items: snapshot.data
                              .map<DropdownMenuItem<FlutterCategory>>(
                                  (FlutterCategory category) {
                            return DropdownMenuItem<FlutterCategory>(
                                value: category,
                                child: Text(category.name,
                                    style:
                                        TextStyle(color: Color(0xFF97b8ea))));
                          }).toList(),

                          onChanged: (FlutterCategory newValue) {
                            selectedCategoryId = newValue.id.toString();
                          },
                        );
                      }
                    }),
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
    apiProvider.create(title, content, selectedCategoryId);

    bindingContent.text = '';
    bindingTitle.text = '';

    Navigator.pop(context);
  }

  void popupButtonSelected(String value) {}
}
