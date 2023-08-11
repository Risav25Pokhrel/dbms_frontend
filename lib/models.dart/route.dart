class Routes {
  int? id;
  int? startAtId;
  int? endAtId;

  Routes({this.id, this.startAtId, this.endAtId});

  Routes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startAtId = json['start_at_id'];
    endAtId = json['end_at_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_at_id'] = startAtId;
    data['end_at_id'] = endAtId;
    return data;
  }
}
