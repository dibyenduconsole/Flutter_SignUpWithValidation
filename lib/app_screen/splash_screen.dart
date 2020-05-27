import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_signup_ui/utils/curve_painter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5), 
    ()=>Navigator.of(context).pushNamedAndRemoveUntil('/loginPage', (Route<dynamic> route) => false));

  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.green[800]),
            //child: BackgroundPainter(),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                //color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                     CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60.0,
                      child: Icon(
                        Icons.school,
                        color: Colors.green[800],
                        size: 70.0,
                      ),
                      
                    ),

                    Padding(padding: EdgeInsets.only(top: 20.0
                    ),
                    ),

                    Text("InstaSchool", style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold
                    ),
                    )

                  ],
                ),


              ),
            ),

            Expanded(
              flex: 1,
              child: Container(
               //color: Colors.redAccent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),


                ],
              ),


              ),
            ),
          ]),
        ],
      ),
    );
  }
}
