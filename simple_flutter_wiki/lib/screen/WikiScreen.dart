import 'package:flutter/material.dart';
import 'package:simple_flutter_wiki/control/BottomNavigatorPane.dart';
import 'package:simple_flutter_wiki/control/ListViewFlutterPage.dart';
import 'package:simple_flutter_wiki/provider/WikiRestProvider.dart';

/**
class FlutterWikiApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter Wiki',
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: WikiPage(title: 'Flutter Wiki App'),
      debugShowCheckedModeBanner: false,
    );
  }
}
 */
class WikiPage extends StatefulWidget {
  @override
  _WikiPageState createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(55, 65, 85, 1.0),
        title: Text('Wiki'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () async {
              await _loadFromApi();
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationPane(),
      body: FlutterPageListView(),
    );
  }

  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var apiProvider = WikiRestProvider();
    await apiProvider.findAllPages();
    await apiProvider.findAllCategories();
    // wait for 2 seconds to simulate loading of data
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }
}
