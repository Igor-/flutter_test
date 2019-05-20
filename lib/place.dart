
class Place {
  final String name;
  final String id;
  final String address;
  final String image;
  final List<String> photos;

  Place._({this.name, this.id, this.address, this.image, this.photos});

  factory Place.fromJson(Map<String, dynamic> json) {
    return new Place._(
      name: json['name'],
      id: json['id'].toString(),
      address: json['address'].toString(),
      image: json['image'].toString(),
    );
  }
}