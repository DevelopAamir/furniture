import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/components/logInstate.dart';
import 'package:furniture/firebase/dataManager.dart';
import 'package:furniture/firebase/profileData.dart';
import 'package:furniture/firebase/store.dart';

import 'orderedProduct.dart';

class Profile extends StatelessWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Store store = Store();
    return Scaffold(
      backgroundColor: Color(0xffececec),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20,
          right: 20,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Are you sure to log out ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                  onPressed: () {
                                    store.logOut();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                logInState()));
                                    Fluttertoast.showToast(msg: 'Logged Out');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => logInState()),
                                    );
                                  },
                                  child: Text('Yes'))
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(Icons.logout_outlined)),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(
                        Icons.account_circle,
                        size: 100,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 1.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView(
                  children: [
                    ProfileData(),
                    SizedBox(height: 10),
                    MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyOrders()),
                        );
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo,
                              borderRadius: BorderRadius.circular(15)),
                          height: 50.0,
                          width: 110,
                          child: Center(
                              child: Text("My Orders",
                                  style: TextStyle(color: Colors.white)))),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  final Text detail;
  const DetailCard({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
        decoration: BoxDecoration(
            color: Color(0xffececec),
            borderRadius: BorderRadius.circular(20.0)),
        width: double.infinity,
        child: detail,
      ),
    );
  }
}
