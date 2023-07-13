class FindFalcone {
  String? planetName;
  String? status;
  String? error;

  FindFalcone({
    this.planetName,
    this.status,
    this.error,
  });

  factory FindFalcone.fromJson(Map<String, dynamic> json) => FindFalcone(
        planetName: json["planet_name"],
        status: json["status"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "planet_name": planetName,
        "status": status,
        "error": error,
      };
}
