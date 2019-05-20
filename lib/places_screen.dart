
import 'package:flutter/material.dart';
import 'package:travelask_test/country.dart';
import 'package:travelask_test/city.dart';
import 'package:travelask_test/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlacesScreen extends StatefulWidget {
  // Declare a field that holds the Todo
  final Country country;
  final City city;

  // In the constructor, require a Todo
  PlacesScreen({Key key, @required this.country, @required this.city}) : super(key: key);

  @override
  State createState() {
    return _PlacesyState(country: country, city: city);
  }
}

class _PlacesyState extends State<PlacesScreen> {
  final Country country;
  final City city;

  var isLoading = false;
  var items;

  _PlacesyState({Key key, @required this.country, @required this.city});
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create our UI
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            child: Column(
              children: <Widget>[
                Image.network(items[index].image),
                Text(items[index].address)
              ],
            ),
          );

          //title: Text('${items[index].name} ${items[index].address}'));
        },
      ),
    );
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

    final response = await http.get("http://stage7.rs0.ru/mapi/v1/places?filter[country_id_eq]=${country.id}&filter[city_id_eq]=${city.id}",
        headers: {'authorization': basicAuth});

    if (response.statusCode == 200) {
      items = (json.decode(utf8.decode(response.bodyBytes)) as List).map((data) => new Place.fromJson(data))
          .toList();
      setState(() {
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }
}