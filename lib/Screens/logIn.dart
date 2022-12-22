import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/Screens/reset.dart';
import 'package:furniture/Screens/signup.dart';
import 'package:furniture/components/logInstate.dart';
import 'package:furniture/firebase/store.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String Email = '';
  String Password = '';
  final PasswordEditingController = TextEditingController();
  final EmailEditingController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void logIn() async {
    print(Password);
    print(Email);
    try {
      final User? user = (await auth.signInWithEmailAndPassword(
              email: Email, password: Password))
          .user;

      if (user == null) {
      } else {
        Store().storeData(user);
        Fluttertoast.showToast(msg: 'loged in ');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => logInState()),
        );

        ///Next page
      }
    } catch (e) {
      if (e.toString() ==
          "[firebase_auth/unknown] Given String is empty or null") {
        Fluttertoast.showToast(msg: 'blanks are empty');
      }
      if (e.toString() ==
          "[firebase_auth/invalid-email] The email address is badly formatted.") {
        Fluttertoast.showToast(msg: 'Enter a correct Email');
      }
      if (e.toString() ==
          "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
        Fluttertoast.showToast(msg: 'No registered account');
      } else {
        Fluttertoast.showToast(msg: 'Something wents wrong');
      }

      print(e);

      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          height: double.infinity,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.indigo, fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      children: <Widget>[
                        textField(
                          controller: EmailEditingController,
                          type: TextInputType.emailAddress,
                          label: "Enter your Email",
                          onChanged: (value) {
                            Email = value;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: textField(
                            controller: PasswordEditingController,
                            type: TextInputType.text,
                            label: "Enter your password",
                            onChanged: (value) {
                              Password = value;
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reset()),
                              );
                            },
                            child: Text(
                              "forget password ?",
                              style: TextStyle(color: Colors.indigo),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        logIn();
                        EmailEditingController.clear();
                        PasswordEditingController.clear();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Not have account?"),
                      TextButton(
                        onPressed: () {
                          EmailEditingController.clear();
                          PasswordEditingController.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                        child: Text(
                          "signup ",
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class textField extends StatelessWidget {
  final String label;
  final TextInputType? type;
  final Function(String) onChanged;
  final TextEditingController? controller;
  const textField(
      {Key? key,
      required this.label,
      required this.onChanged,
      required this.type,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.indigo),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          focusColor: Colors.white,
          fillColor: Colors.indigo[100],
          filled: true,
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w300,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
