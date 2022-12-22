import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'logIn.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  var Email = '';
  final EmailEditingController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void reset() async {
    try {
      await auth.sendPasswordResetEmail(email: Email);
      Fluttertoast.showToast(msg: 'Email send');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            textField(
              controller: EmailEditingController,
              label: 'Enter Email',
              onChanged: (value) {
                Email = value;
              },
              type: TextInputType.emailAddress,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
              ),
              onPressed: () {
                EmailEditingController.clear();

                reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LogIn()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
