import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/components/logInstate.dart';
import 'package:furniture/firebase/store.dart';

import 'logIn.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class Signup extends StatefulWidget {
  // const LogIn({ Key? key }) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final EmailEditingController = TextEditingController();
  final PasswordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final addressEditingController = TextEditingController();
  final NameEditingController = TextEditingController();
  final toastMessageEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();

  var password = '';
  String email = '';
  String confirmPassword = '';
  String name = '';
  String toastMessage = '';
  String address = '';
  String phoneNumber = '';

  // CollectionReference collectionReference =
  //     FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    String loggedinUser = '';
    void getCurrentUser() async {
      try {
        final user = auth.currentUser;
        if (user != null) {
          setState(() {
            loggedinUser = user.email.toString();
          });

          print(loggedinUser);
        }
      } catch (e) {
        print(e);
      }
    }

    void Register() async {
      if (name != '' && address != '' && phoneNumber != '') {
        if (password == confirmPassword) {
          try {
            final User? user = (await auth.createUserWithEmailAndPassword(
                    email: email, password: password))
                .user;

            if (user == null) {
            } else {
              Store().storeData(user);
              getCurrentUser();
              print('loggedinUser');
              print(loggedinUser);
              Fluttertoast.showToast(msg: 'Signed up');
              setState(() {
                toastMessage = 'Signed up';
              });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => logInState()),
              );
            }
          } catch (e) {
            if (e.toString() ==
                "[firebase_auth/unknown] Given String is empty or null") {
              Fluttertoast.showToast(msg: 'blanks are empty');
              setState(() {
                toastMessage = 'blanks are empty';
              });
            }
            if (e.toString() ==
                "[firebase_auth/invalid-email] The email address is badly formatted.") {
              Fluttertoast.showToast(msg: 'Enter a correct email');
              setState(() {
                toastMessage = 'Enter a correct email';
              });
            }
            if (e.toString() ==
                "[firebase_auth/weak-password] password should be at least 6 characters") {
              Fluttertoast.showToast(
                  msg: 'password must be at least6 6 characters');
              setState(() {
                toastMessage = 'password must be at least6 6 characters';
              });
            } else {
              Fluttertoast.showToast(msg: 'Something wents wrong');
              setState(() {
                toastMessage = 'Something wents wrong';
              });
            }

            print(e);
            setState(() {
              toastMessage = e.toString();
            });
          }
        } else {
          Fluttertoast.showToast(
              msg: 'fill both password ande confirm password with same value');
          setState(() {
            toastMessage =
                'fill both password ande confirm password with same value';
          });
        }
        if (toastMessage == 'Signed up') {
          _firestore
              .collection(loggedinUser)
              .add({'Name': name, 'address': address, 'Number': phoneNumber});
        }
      } else {
        Fluttertoast.showToast(msg: 'fill out the blanks');
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.indigo, fontSize: 50),
                ),
              ),
              Column(
                children: <Widget>[
                  textField(
                    controller: EmailEditingController,
                    label: "Enter your email",
                    onChanged: (value) {
                      print(value);
                      email = value;
                    },
                    type: TextInputType.emailAddress,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: textField(
                      controller: PasswordEditingController,
                      type: TextInputType.visiblePassword,
                      onChanged: (value) {
                        password = value;
                      },
                      label: "Enter password",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: textField(
                      controller: confirmPasswordEditingController,
                      onChanged: (value) {
                        confirmPassword = value;
                      },
                      label: "Confirm password",
                      type: TextInputType.visiblePassword,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: textField(
                      controller: NameEditingController,
                      onChanged: (value) {
                        name = value;
                      },
                      label: "Enter name",
                      type: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: textField(
                      controller: addressEditingController,
                      onChanged: (value) {
                        address = value;
                      },
                      label: "Enter address",
                      type: TextInputType.streetAddress,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: textField(
                      controller: phoneNumberEditingController,
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      label: "Enter your Number",
                      type: TextInputType.number,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () async {
                  EmailEditingController.clear();
                  PasswordEditingController.clear();
                  confirmPasswordEditingController.clear();
                  phoneNumberEditingController.clear();
                  addressEditingController.clear();
                  NameEditingController.clear();

                  Register();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    "Sign up",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LogIn()),
                      );
                    },
                    child: Text(
                      "Log In ",
                    ),
                  )
                ],
              )
            ],
          ),
        ]),
      )),
    );
  }
}
