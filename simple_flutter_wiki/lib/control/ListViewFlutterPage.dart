import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FlutterPageListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlutterPage>>(
      future: _fetchPages(),
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

  ListView _pageListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(
              data[index], data[index].title, data[index].content, Icons.work);
        });
  }

  ListTile _tile(dynamic data, String title, String subtitle, IconData icon) =>
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
        onTap: () => onTileClicked(data),
      );

  void onTileClicked(dynamic data) {
    print(data.title);
  }
}
