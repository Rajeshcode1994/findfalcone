import 'package:findingfalcone/helper/utilities.dart';
import 'package:findingfalcone/plannet/models/find_falcone.dart';
import 'package:findingfalcone/plannet/models/planets.dart';
import 'package:findingfalcone/plannet/models/token.dart';
import 'package:findingfalcone/plannet/models/vehicles.dart';
import 'package:findingfalcone/plannet/screens/failed_screen.dart';
import 'package:findingfalcone/plannet/screens/success_screen.dart';
import 'package:findingfalcone/plannet/services/plannet_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanetViewModel extends ChangeNotifier {
  List<Planets> planets = [];
  List<Vehicles> vehicles = [];
  Token token = Token();
  FindFalcone falcone = FindFalcone();
  int totalDuration = 0;
  Planets? selectedPlanet;
  Vehicles? selectedVehicle;
  List<String> selectedVehicles = [];
  List<String> selectedPlanets = [];
  List<Planets> newPlanet = [];
  List<Vehicles> newVehicles = [];

  initialize() {
    fetchPlanet();
    fetchVehicles();
  }

  reset() {
    selectedPlanets.clear();
    selectedVehicles.clear();
    newVehicles.clear();
    newPlanet.clear();
  }

  fetchPlanet() {
    PlanetServices.fetchPlanets().then((planetResponse) {
      if (planetResponse != null) {
        planets = planetResponse.planetList!;
      } else {
        debugPrint("Error ------ $planetResponse");
      }
      notifyListeners();
    });
  }

  fetchVehicles() {
    PlanetServices.fetchVehicles().then((vehicleResponse) {
      if (vehicleResponse != null) {
        vehicles = vehicleResponse.vehicleList!;
      } else {
        debugPrint("Error ------ $vehicleResponse");
      }
      notifyListeners();
    });
  }

  getToken(BuildContext context) {
    Utilities.showProgress(context);
    PlanetServices.fetchToken().then((tokenResponse) {
      if (tokenResponse != null) {
        token = tokenResponse;
        findFalcone(context);
      } else {
        debugPrint("Token Error ------ $tokenResponse");
      }
      notifyListeners();
    });
  }

  findFalcone(BuildContext context) {
    String token = this.token.token!;
    List<String> findPlanet = selectedPlanets;
    List<String> findVehicle = selectedVehicles;
    PlanetServices.sendFindRequest(token, findPlanet, findVehicle).then((falconeResponse) {
      Utilities.hideProgress(context);
      if (falconeResponse != null) {
        checkFalconeStatus(
            context, falconeResponse.status!);
        print(falconeResponse.status!.toString());
      } else {
        debugPrint("Error ------ $falconeResponse");
      }
      notifyListeners();
    });
  }

  checkFalconeStatus(BuildContext context, String status) {
    switch (status) {
      case "success":
        Utilities.pushReplacement(context, const SuccessScreen());
        break;
      case "false":
        Utilities.pushReplacement(context, const FailedScreen());
        break;
      default:
        return renderErrorDialog(context, "API Error");
    }
  }

  renderErrorDialog(BuildContext context, String error) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation: 1,
            alignment: Alignment.center,
            insetPadding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(
                          CupertinoIcons.clear_circled_solid,
                          color: Colors.black,
                          size: 25,
                        ))
                  ],
                ),
                const Divider(
                  color: Colors.black45,
                ),
                Text(
                  error,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
  }

  onPlanetSelected(value) {
    if(value != null) {
      if(selectedPlanets.length > 4) {
        selectedPlanets.remove(value);
      } else {
        selectedPlanets.add(value);
      }
      notifyListeners();
    }
  }

  onVehicleSelected(value) {
    if(value != null) {
      if(selectedVehicles.length > 4) {
        selectedVehicles.remove(value);
      } else {
        selectedVehicles.add(value);
      }
      notifyListeners();
    }
  }

  calculateFalconeDistance() {
    int totalDuration = 0;
    for(int i=0; i<newPlanet.length; i++){
      for(int j=0; j<newVehicles.length; j++) {
        if (newPlanet[i].distance! < newVehicles[j].maxDistance!) {
          int duration =
          (newPlanet[i].distance! / newVehicles[j].speed!).truncate();
          totalDuration += duration;
        }
      }
    }
    return totalDuration;
  }
}
