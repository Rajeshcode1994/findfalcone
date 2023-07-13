import 'package:findingfalcone/plannet/screens/on_board_screen.dart';
import 'package:findingfalcone/plannet/screens/planet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FailedScreen extends StatefulWidget {
  const FailedScreen({Key? key}) : super(key: key);

  @override
  State<FailedScreen> createState() => _FailedScreenState();
}

class _FailedScreenState extends State<FailedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          Icon(CupertinoIcons.clear_thick_circled, size: 140, color: Colors.red.shade900,),
          SizedBox(
            height: 20,
          ),
          const Center(
            child: Text("Your plannet cannot find please try again later", style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red.shade900,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: const Text("Try Again", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), textAlign: TextAlign.center,),),
          ),
          Spacer()
        ],
      ),
    );
  }
}
