import 'package:findingfalcone/plannet/models/vehicles.dart';
import 'package:findingfalcone/plannet/view_models/planet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VehicleSelectionScreen extends StatefulWidget {
  const VehicleSelectionScreen({Key? key})
      : super(key: key);

  @override
  State<VehicleSelectionScreen> createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF213363),
      body: Consumer<PlanetViewModel>(builder: (context, vehicleData, _) {
        return Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFF9BCDD2)
              ),
              child: const Center(
                  child: Text("Find Falcone",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 42),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black12,
                  child: Icon(Icons.arrow_back,
                      color: Color(0xFF213363), size: 16),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  margin: const EdgeInsets.only(top: 240),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color(0xFF213363),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Card(
                          margin: const EdgeInsets.all(12),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 18),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Planet Name"),
                                    Text("Planet Distance"),
                                  ],
                                ),
                                const Divider(),
                                ListView.builder(
                                    itemCount: vehicleData.newPlanet.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(vehicleData.newPlanet[index].name!),
                                          Text(vehicleData.newPlanet[index].distance!.toString()),
                                        ],
                                      );
                                    }),
                                const Divider(),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Vehicle Name"),
                                    Text("Vehicle Speed"),
                                  ],
                                ),
                                const Divider(),
                                ListView.builder(
                                    itemCount: vehicleData.newVehicles.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index){
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(vehicleData.newVehicles[index].name!),
                                          Text(vehicleData.newVehicles[index].speed!.toString()),
                                        ],
                                      );
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                          child: TextFormField(
                            autofocus: false,
                            readOnly: true,
                            controller: TextEditingController()
                              ..text =
                                  vehicleData.calculateFalconeDistance() != null
                                      ? vehicleData
                                          .calculateFalconeDistance()
                                          .toString()
                                      : '',
                            validator: (value) {
                              if(value == null || value.isEmpty) {
                                return "Time is not available";
                              }
                              return null;
                            },
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Time Taken',
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        InkWell(
                          onTap: () {
                            if(_formKey.currentState!.validate()) {
                              context.read<PlanetViewModel>().getToken(context);
                            }
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            margin: const EdgeInsets.symmetric(horizontal: 14),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Find Falcone",
                                  style: TextStyle(
                                      color: Color(0xFF213363),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.double_arrow, color: Colors.black,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
