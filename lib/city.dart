
class City {
  final String name;
  final String id;

  City._({this.name, this.id});

  factory City.fromJson(Map<String, dynamic> json) {
    return new City._(
      name: json['name'],
      id: json['id'].toString(),
    );
  }
}