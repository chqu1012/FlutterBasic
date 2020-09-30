import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simple_flutter_wiki/control/ListViewFlutterPage.dart';
import 'dart:convert';
import 'model/FlutterPage.dart';

void main() => runApp(FlutterWikiApp());

Future<List<FlutterPage>> fetchPages(int index) async {
  final response = await http.get('http://192.168.0.157:8080/pages');
  if (response.statusCode == 200) {
    Iterable list = json.decode(response.body);
    return list.map((model) => FlutterPage.fromJson(model)).toList();
  } else {
    throw Exception('Failed to load page with id $index');
  }
}

class FlutterWikiApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter Wiki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WikiPage(title: 'Flutter Wiki App'),
    );
  }
}

class WikiPage extends StatefulWidget {
  WikiPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FlutterPageListView(),
    );
  }
}
