class Buses {
  late String busname;
  late String licensePlate;
  late String type;
  late String capacity;
  late String url;

  Buses(
      {required this.licensePlate,
      required this.busname,
      required this.type,
      required this.capacity,
      required this.url});

  Buses.fromJson(Map<String, dynamic> json) {
    busname = json['busname'] ?? "BUSNAME";
    licensePlate = json['license_plate'];
    type = json['type'];
    capacity = json['capacity'].toString();
    url = json['url'] ?? "assets/logo.png";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["busname"] = busname;
    data['license_plate'] = licensePlate;
    data['type'] = type;
    data['capacity'] = int.parse(capacity);
    data['url'] = url;
    return data;
  }
}
