import 'package:findingfalcone/plannet/screens/on_board_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
          Icon(CupertinoIcons.check_mark_circled_solid, size: 140, color: Colors.green.shade900,),
          SizedBox(
            height: 20,
          ),
          const Center(
            child: Text("Your planet is find please enjoy the planet", style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold
            ),),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> OnBoardScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green.shade900,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              child: const Text("Back To Home", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white), textAlign: TextAlign.center,),),
          ),
          Spacer()
        ],
      ),
    );
  }
}
