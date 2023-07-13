class VehicleList {
  List<Vehicles>? vehicleList;

  VehicleList({this.vehicleList});

  factory VehicleList.fromJson(List<dynamic> json) => VehicleList(
      vehicleList: List<Vehicles>.from(json.map((x) => Vehicles.fromJson(x))));
}

class Vehicles {
  String? name;
  int? totalNo;
  int? maxDistance;
  int? speed;

  Vehicles({
    this.name,
    this.totalNo,
    this.maxDistance,
    this.speed,
  });

  factory Vehicles.fromJson(Map<String, dynamic> json) => Vehicles(
        name: json["name"],
        totalNo: json["total_no"],
        maxDistance: json["max_distance"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "total_no": totalNo,
        "max_distance": maxDistance,
        "speed": speed,
      };
}
