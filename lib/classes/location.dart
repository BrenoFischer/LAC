class Location {
  final String id;
  final String type;
  final double lat;
  final double lng;
  final double high;
  final String data;

  Location(this.id, this.type, this.lat, this.lng, this.high, this.data);

  Location.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        lat = json['lat'],
        lng = json['lng'],
        high = json['high'],
        data = json['data'];
}
