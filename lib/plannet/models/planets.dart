import 'package:findingfalcone/plannet/models/vehicles.dart';

class PlanetList {
  List<Planets>? planetList;

  PlanetList({this.planetList});

  factory PlanetList.fromJson(List<dynamic> json) => PlanetList(
      planetList: List<Planets>.from(json.map((x) => Planets.fromJson(x))));
}

class Planets {
  String? name;
  int? distance;
  String? image;
  Vehicles? vehicles;

  Planets({
    this.name,
    this.distance,
    this.image,
    this.vehicles
  });

  factory Planets.fromJson(Map<String, dynamic> json) => Planets(
        name: json["name"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "distance": distance,
      };
}