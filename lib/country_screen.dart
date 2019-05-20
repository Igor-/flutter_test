import 'package:flutter/material.dart';
import 'package:travelask_test/country.dart';
import 'package:travelask_test/city.dart';
import 'package:travelask_test/places_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryScreen extends StatefulWidget {
  // Declare a field that holds the Todo
  final Country country;

  // In the constructor, require a Todo
  CountryScreen({Key key, @required this.country}) : super(key: key);

  @override
  State createState() {
    return _CountryState(country: country);
  }
}

class _CountryState extends State<CountryScreen> {
  final Country country;

  var isLoading = false;
  var items;

  _CountryState({Key key, @required this.country});
  @override
  Widget build(BuildContext context) {
      // Use the Todo to create our UI
      return Scaffold(
        appBar: AppBar(
          title: Text(country.name),
        ),
        body: isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text('${items[index].name}'), onTap: () => onTapped(country, items[index], context),);
          },
        ),
      );
    }

    void onTapped(Country country, City city, BuildContext context) {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlacesScreen(country: country, city: city)
      ));
    }

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

    final response = await http.get("http://stage7.rs0.ru/mapi/v1/cities?filter[country_id_eq]=${country.id}",
        headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      items = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => new City.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }
}