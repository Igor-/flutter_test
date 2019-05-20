
class Country {
  final String name;
  final String id;

  Country._({this.name, this.id});

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country._(
      name: json['name'],
      id: json['id'].toString(),
    );
  }
}
