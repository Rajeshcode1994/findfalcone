import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:findingfalcone/helper/app_urls.dart';
import 'package:findingfalcone/plannet/models/find_falcone.dart';
import 'package:findingfalcone/plannet/models/planets.dart';
import 'package:findingfalcone/plannet/models/token.dart';
import 'package:findingfalcone/plannet/models/vehicles.dart';
import 'package:flutter/cupertino.dart';

import '../../helper/network_adapter.dart';

class PlanetServices {
  static Future<PlanetList?> fetchPlanets() async {
    try {
      Response response =
          await NetworkAdapters.shared.get(endPoint: AppUrls.planets);
      //final responseJson = json.decode(response.data);
      return PlanetList.fromJson(response.data);
    } catch (error) {
      debugPrint("Error  ----  $error");
    }
    return null;
  }

  static Future<VehicleList?> fetchVehicles() async {
    try {
      Response response =
          await NetworkAdapters.shared.get(endPoint: AppUrls.vehicles);
      //final responseJson = json.decode(response.data);
      return VehicleList.fromJson(response.data);
    } catch (error) {
      debugPrint("Error  ----  $error");
    }
    return null;
  }

  static Future<Token?> fetchToken() async {
    try {
      Dio dio = Dio();
      dio.options.headers['Accept'] = 'application/json';

      Response response = await dio.post(AppUrls.generate_token);

      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.data);
        return token;
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle Dio errors
      print('Error: $error');
      return null;
    }
  }


  static Future<FindFalcone?> sendFindRequest(String token, List<String> selectedPlanets, List<String> selectedVehicles) async {
    try {
      Dio dio = Dio();
      dio.options.headers['Accept'] = 'application/json';
      dio.options.headers['Content-Type'] = 'application/json';

      // Create the request body
      Map<String, dynamic> requestBody = {
        'token': token,
        'planet_names': selectedPlanets,
        'vehicle_names': selectedVehicles,
      };

      // Convert the request body to JSON
      String jsonBody = json.encode(requestBody);

      // Make the POST request
      Response response = await dio.post(
        'https://findfalcone.geektrust.com/find',
        data: jsonBody,
      );

      print('Response: ${response.data}');
      if (response.statusCode == 200) {
        // Success response
        print('Success!');
        FindFalcone findFalcone = FindFalcone.fromJson(response.data);
        return findFalcone;
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle Dio errors
      print('Error: $error');
      return null;
    }
  }
}
