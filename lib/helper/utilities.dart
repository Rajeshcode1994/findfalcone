import 'package:flutter/material.dart';

class Utilities {
  static Future<dynamic> push(BuildContext context, Widget screen) async {
    return await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  static void pushCompleteReplacement(BuildContext context, Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
            (Route<dynamic> route) => false);
  }

  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  static showProgress(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            // ignore: missing_return
            onWillPop: null,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Card(
                    elevation: 0,
                    semanticContainer: false,
                    color: Colors.transparent,
                    child: Text(
                      "Fetching Falcone",
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * .5,
                      child: const LinearProgressIndicator(
                        minHeight: 5,
                      )),
                ],
              ),
            ),
          );
        });
  }

  static hideProgress(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  static showInSnackBar(BuildContext context, String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        duration: const Duration(milliseconds: 1000),
        content: Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        )));
  }
}