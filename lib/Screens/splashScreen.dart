import 'package:flutter/material.dart';
import 'package:furniture/components/logInstate.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (MediaQuery.of(context).size.height >
            MediaQuery.of(context).size.width) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => logInState()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Landscape()),
          );
        }
      },
      child: Scaffold(
          body: Center(
              child: Text(
        "Furniture",
        style: TextStyle(color: Colors.purple.shade800, fontSize: 50.0),
      ))),
    );
  }
}

class Landscape extends StatelessWidget {
  const Landscape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red,
        body: Center(
            child: Text('Landscape Mode is not supported yet',
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ))));
  }
}
