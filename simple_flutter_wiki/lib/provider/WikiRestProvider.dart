import 'package:simple_flutter_wiki/model/FlutterCategory.dart';
import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'DBProvider.dart';

class WikiRestProvider {
  Future<http.Response> login(String username, String password) {
    return http.post(
      'http://192.168.0.157:8080/user/authentification',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{"username": username, "password": password}),
    );
  }

  Future<List<FlutterPage>> findAllPages() async {
    final pagesListAPIUrl = 'http://192.168.0.157:8080/pages';
    final response = await http.get(pagesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<FlutterPage> pages = jsonResponse.map((page) {
        print('Inserting $page');
        DBProvider.db.insertPage(FlutterPage.fromJson(page));
      }).toList();

      return pages;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<FlutterCategory>> findAllCategories() async {
    final pagesListAPIUrl = 'http://192.168.0.157:8080/categories';
    final response = await http.get(pagesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<FlutterCategory> categories = jsonResponse.map((category) {
        print('Inserting $category');
        DBProvider.db.insertCategory(FlutterCategory.fromJson(category));
      }).toList();

      return categories;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<http.Response> create(
      String title, String content, String categoryId) {
    return http.post(
      'http://192.168.0.157:8080/newpage',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'content': content,
        'categoryId': categoryId,
      }),
    );
  }
}
