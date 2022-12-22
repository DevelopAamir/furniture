import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture/Screens/admin.dart';
import 'package:furniture/Screens/bottomNavigation.dart';
import 'package:furniture/Screens/logIn.dart';
import 'package:furniture/firebase/store.dart';

class logInState extends StatefulWidget {
  const logInState({Key? key}) : super(key: key);

  @override
  _logInStateState createState() => _logInStateState();
}

class _logInStateState extends State<logInState> {
  Store data = Store();
  Widget currentPage = LogIn();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    String? user = await data.getData('user');

    if (user != null) {
      print('$user');
      setState(() {
        if (user == 'raosao61@gmail.com') {
          currentPage = Admin();
        } else {
          currentPage = Navigat();
        }
      });
    }
  }

  Future<bool> _onBackpressed() async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('are you really want to exit the app ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text('No'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                  exit(0);
                },
                child: Text('Exit'))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackpressed, child: currentPage);
  }
}
