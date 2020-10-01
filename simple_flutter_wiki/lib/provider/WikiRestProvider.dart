import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'DBProvider.dart';

class WikiRestProvider {
  Future<List<FlutterPage>> findAllPages() async {
    final pagesListAPIUrl = 'http://192.168.0.157:8080/pages';
    final response = await http.get(pagesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<FlutterPage> pages = jsonResponse.map((page) {
        print('Inserting $page');
        DBProvider.db.insert(FlutterPage.fromJson(page));
      }).toList();

      return pages;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<http.Response> create(String title, String content) {
    return http.post(
      'http://192.168.0.157:8080/newpage',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
        'categoryId': '2',
      }),
    );
  }
}
