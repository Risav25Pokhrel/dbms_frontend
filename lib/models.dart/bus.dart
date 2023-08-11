class Buses {
  late String busname;
  late String licensePlate;
  late String type;
  late String capacity;
  late String url;
  late dynamic route;
  late List<String> availableSeat;
  late double rate;
  late String deptime;

  Buses(
      {required this.licensePlate,
      required this.busname,
      required this.type,
      required this.capacity,
      required this.url,
      required this.route,
      required this.availableSeat,
      required this.deptime,
      required this.rate});

  Buses.fromJson(Map<String, dynamic> json) {
    busname = json['busname'] ?? "BUSNAME";
    licensePlate = json['license_plate'];
    type = json['type'];
    capacity = json['capacity'].toString();
    url = json['url'] ?? "assets/logo.png";
    route = json['route'] ?? [1, 8, 5, 6];
    deptime = json["deptime"] ?? "3:45 PM";
    availableSeat = json['availableSeat'] ??
        ["K1", "B2", "A14", "A9", "A4", "B1", "B4", "B5", "B16"];
    rate = json['rate'] ?? 1500.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["busname"] = busname;
    data['license_plate'] = licensePlate;
    data['type'] = type;
    data['capacity'] = int.parse(capacity);
    data['url'] = url;
    data['route'] = route;
    data['availableSeat'] = availableSeat;
    data['rate'] = rate.toString();
    return data;
  }
}
