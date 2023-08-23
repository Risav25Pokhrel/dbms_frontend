class Trips {
  late String busNumber;
  late String busName;
  late int tripId;
  late String startAt;
  late String endAt;
  late String departure;
  late String arrival;
  late int price;
  late int availableSeats;
  late String imageUrl;
  late int rows;
  // late Businfo bus;

  Trips({
    required this.busNumber,
    required this.busName,
    required this.tripId,
    required this.startAt,
    required this.endAt,
    required this.departure,
    required this.arrival,
    required this.price,
    required this.availableSeats,
    required this.imageUrl,
    required this.rows
  });

  factory Trips.fromJson(Map<String, dynamic> json) {
    return Trips(
      busNumber: json['bus_number'],
      busName: json['bus_name'],
      tripId: json['trip_id'],
      startAt: json['start_at'],
      endAt: json['end_at'],
      departure: json['departure'],
      arrival: json['arrival'],
      price: json['price'],
      availableSeats: json['available_seats'],
      imageUrl: json["image_url"],
      rows: json['rows']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bus_number'] = busNumber;
    data['bus_name'] = busName;
    data['trip_id'] = tripId;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['departure'] = departure;
    data['arrival'] = arrival;
    data['price'] = price;
    data['available_seats'] = availableSeats;
    return data;
  }
}
