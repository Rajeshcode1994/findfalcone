import 'dart:async';
import 'dart:io';

import 'package:findingfalcone/helper/utilities.dart';
import 'package:findingfalcone/plannet/screens/on_board_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _isConnectedToInternet().then((isConnected) async {
      if (isConnected) {
        startTimer();
      } else {
        Utilities.showInSnackBar(
            context, "Please check your network connection");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF2E6F80),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Align(
          child: Text("Falcone", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }

  startTimer() async {
    Timer(const Duration(seconds: 3), () async {
      Utilities.pushReplacement(context, const OnBoardScreen());
    });
  }

  Future<bool> _isConnectedToInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
