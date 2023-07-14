class Buses {
  String? licensePlate;
  String? type;
  int? capacity;

  Buses({this.licensePlate, this.type, this.capacity});

  Buses.fromJson(Map<String, dynamic> json) {
    licensePlate = json['license_plate'];
    type = json['type'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['license_plate'] = licensePlate;
    data['type'] = type;
    data['capacity'] = capacity;
    return data;
  }
}
