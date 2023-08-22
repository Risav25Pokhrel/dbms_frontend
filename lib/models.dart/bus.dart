class Buses {
  late String busname;
  late String licensePlate;
  late String type;
  late String imageUrl;  

  Buses(
      {required this.licensePlate,
      required this.busname,
      required this.type,
      required this.imageUrl
     });

  Buses.fromJson(List<dynamic> json) {
    busname = json[1] ;
    licensePlate = json[0];
    type = json[3];
    imageUrl= json[2] ?? "assets/logo.png";
  }
}
