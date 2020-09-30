import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/control/DetailedPane.dart';
import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_flutter_wiki/provider/DBProvider.dart';

class FlutterPageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlutterPage>>(
      future: DBProvider.db.getAllPages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<FlutterPage> data = snapshot.data;
          return _pageListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<FlutterPage>> _fetchPages() async {
    final pagesListAPIUrl = 'http://192.168.0.157:8080/pages';
    final response = await http.get(pagesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((page) => new FlutterPage.fromJson(page))
          .toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Card createCard(BuildContext context, dynamic data) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            data.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(" Intermediate", style: TextStyle(color: Colors.white))
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () => onTileClicked(context, data),
        ),
      ),
    );
  }

  ListView _pageListView(data) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // return _tile(
          //     data[index], data[index].title, data[index].content, Icons.work);
          return createCard(context, data[index]);
        });
  }

  ListTile _tile(BuildContext context, dynamic data, String title,
          String subtitle, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        onTap: () => onTileClicked(context, data),
      );

  void onTileClicked(BuildContext context, FlutterPage data) {
    print(data.title);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DetailedPane(page: data)));
  }
}
