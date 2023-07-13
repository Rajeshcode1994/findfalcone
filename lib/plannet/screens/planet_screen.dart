import 'package:findingfalcone/helper/utilities.dart';
import 'package:findingfalcone/plannet/screens/vehicle_screen.dart';
import 'package:findingfalcone/plannet/view_models/planet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/planets.dart';
import '../models/vehicles.dart';

class PlanetScreen extends StatefulWidget {
  const PlanetScreen({Key? key}) : super(key: key);

  @override
  State<PlanetScreen> createState() => _PlanetScreenState();
}

class _PlanetScreenState extends State<PlanetScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<PlanetViewModel>().reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Select Your Planet"),
        centerTitle: true,
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Consumer<PlanetViewModel>(builder: (context, planetData, _) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: planetData.planets.isNotEmpty
                          ? planetData.planets.length - 2
                          : 0,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF9BCDD2),
                            borderRadius: BorderRadius.circular(18)
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          child: ExpansionTile(
                            childrenPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            title: Text(
                              "Planet ${index + 1}",
                              style: const TextStyle(
                                  color: Color(0xFF213363),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            initiallyExpanded: true,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5, left: 5, right: 0, top: 3),
                                padding: const EdgeInsets.only(right: 5),
                                child: DropdownButtonFormField<Planets>(
                                  autofocus: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF213363))),
                                      errorStyle: const TextStyle(height: 0)),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select planet";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hint: const Text(
                                    "Your Planet",
                                    style: TextStyle(
                                        color: Color(0xFF213363), fontSize: 12),
                                    textAlign: TextAlign.justify,
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  value: planetData.selectedPlanet != null
                                      ? planetData.selectedPlanet!
                                      : null,
                                  items: planetData.planets.map((value) {
                                    return DropdownMenuItem<Planets>(
                                      value: value,
                                      child: Text(
                                        value.name!.toUpperCase(),
                                        style: const TextStyle(
                                            color: Color(0xFF213363), fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (planetData.newPlanet.length > 4) {
                                      planetData.newPlanet.remove(value);
                                    } else {
                                      planetData.newPlanet.add(value!);
                                    }
                                    planetData.onPlanetSelected(value!.name);
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 5, left: 5, right: 0, top: 3),
                                padding: const EdgeInsets.only(right: 5),
                                child: DropdownButtonFormField<Vehicles>(
                                  autofocus: false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Color(0xFF213363))),
                                      errorStyle: const TextStyle(height: 0)),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Select Vehicle";
                                    } else {
                                      return null;
                                    }
                                  },
                                  hint: const Text(
                                    "Your Vehicle",
                                    style: TextStyle(
                                        color: Color(0xFF213363), fontSize: 12),
                                    textAlign: TextAlign.justify,
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  value: planetData.selectedVehicle != null
                                      ? planetData.selectedVehicle!
                                      : null,
                                  items: planetData.vehicles.map((value) {
                                    return DropdownMenuItem<Vehicles>(
                                      value: value,
                                      child: Text(
                                        value.name!.toUpperCase(),
                                        style: const TextStyle(
                                            color: Color(0xFF213363), fontSize: 18),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    if (planetData.newVehicles.length > 4) {
                                      planetData.newVehicles.remove(value);
                                    } else {
                                      planetData.newVehicles.add(value!);
                                    }
                                    planetData.onVehicleSelected(value!.name);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                InkWell(
                  onTap: () {
                    if(_formKey.currentState!.validate()) {
                      Utilities.push(context, const VehicleSelectionScreen());
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFF213363),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> createRadioListUsers(List<Vehicles> vehicles) {
    List<Widget> widgets = [];
    for (Vehicles vehicle in vehicles) {
      widgets.add(
        Consumer<PlanetViewModel>(builder: (context, data, _) {
          return RadioListTile(
            value: vehicle,
            groupValue: data.selectedVehicle,
            title: Text(vehicle.name!, style: const TextStyle(color: Color(0xFF213363)),),
            onChanged: (currentUser) {
              data.onVehicleSelected(currentUser);
            },
            selected: data.selectedVehicle == vehicle,
            activeColor: const Color(0xFF213363),
          );
        }),
      );
    }
    return widgets;
  }
}
