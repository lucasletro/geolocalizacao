import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocalizacao/src/pages/home_page/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer( const Duration(seconds: 3), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Home()));
    });
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient( //degrade nas cores
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade300,
                Colors.blue.shade700,
                Colors.blue,
              ]
          )
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [

          Image.asset("assets/logo.png"),

          const SizedBox(height: 10,), //espaçamento entre os widgets

          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),

        ],
      ),

    );
  }
}
