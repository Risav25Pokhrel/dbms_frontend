
class Stops {
  int? id;
  String? name;

  Stops({this.id, this.name});

  Stops.fromJson(Map<String, dynamic> json) {
     Stops(
      id: json['id'],
      name: json['name'],
    );
  }
 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
