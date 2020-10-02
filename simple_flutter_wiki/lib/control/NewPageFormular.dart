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
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: bindingTitle,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: bindingContent,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Content',
                    ),
                  ),
                ),
                new Text(
                  "Category",
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: const Color.fromRGBO(55, 65, 85, 1.0),
                      fontWeight: FontWeight.w200,
                      fontFamily: "Roboto"),
                ),
                FutureBuilder(
                    future: DBProvider.db.findAllCategories(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) return Text(snapshot.error);

                      if (snapshot.hasData) {
                        return DropdownButtonFormField(
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
                Container(
                    height: 50,
                    width: 300,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Create'),
                      onPressed: () => buttonPressed(context),
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
