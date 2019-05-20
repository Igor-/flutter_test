import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'dart:developer';
import 'package:travelask_test/country.dart';
import 'package:travelask_test/country_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MainFetchDataState createState() {
    return _MainFetchDataState();
  }
}

class _MainFetchDataState extends State<MyApp> {
  var items;
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    _fetchData();
  }

  _fetchData() async {
    setState(() {
      isLoading = true;
    });

    String username = 'rocket';
    String password = 'rocket';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    final response = await http.get("http://stage7.rs0.ru/mapi/v1/countries",
        headers: {'authorization': basicAuth, "content-type" : "application/json; charset=utf-8"});
    if (response.statusCode == 200) {
      items = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => new Country.fromJson(data))
          .toList();
      print(items);
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text('${items[index].name}'), onTap: () => onTapped(items[index], context),);
                  },
                )),
    );
  }

  void onTapped( Country country, BuildContext context) {
    print(country.id.toString());
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => CountryScreen(country: country)
    ));
  }
}
