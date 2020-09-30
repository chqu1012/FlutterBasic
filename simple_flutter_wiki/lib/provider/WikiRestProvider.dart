import 'package:simple_flutter_wiki/model/FlutterPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'DBProvider.dart';

class WikiRestProvider {
  /**  Future<List<Employee>> getAllEmployees() async {
    var url = "http://demo8161595.mockable.io/employee";
    Response response = await Dio().get(url);

    return (response.data as List).map((employee) {
      print('Inserting $employee');
      DBProvider.db.createEmployee(Employee.fromJson(employee));
    }).toList();
  }*/

  Future<List<FlutterPage>> findAllPages() async {
    final pagesListAPIUrl = 'http://192.168.0.157:8080/pages';
    final response = await http.get(pagesListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      List<FlutterPage> pages = jsonResponse.map((page) {
        print('Inserting $page');
        DBProvider.db.createEmployee(FlutterPage.fromJson(page));
      }).toList();

      return pages;
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }
}
