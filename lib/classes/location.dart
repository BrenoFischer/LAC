class Location {
  final String sensor;
  final int time;
  final List<double> data;

  Location(this.sensor, this.time, this.data);

  Location.fromJson(Map<String, dynamic> json)
      : sensor = json['sensor'],
        time = json['time'],
        data = json['data'].cast<double>();
}
