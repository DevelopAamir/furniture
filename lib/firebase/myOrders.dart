import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/components/orders.dart';

import 'dataManager.dart';

class MyordersData extends StatefulWidget {
  const MyordersData({Key? key}) : super(key: key);

  @override
  _MyordersDataState createState() => _MyordersDataState();
}

class _MyordersDataState extends State<MyordersData> {
  final _firestore = FirebaseFirestore.instance;

  String loggedinUser = '';
  String username = '';
  String useraddress = '';
  String usernumber = '';

  void userData() async {
    try {
      FirebaseFirestore.instance
          .collection(loggedinUser)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          setState(() {
            username = doc["Name"];
            useraddress = doc["address"];
            usernumber = doc["Number"].toString();
            print("aa");
          });
          print('aa' + doc["address"]);
        });
      });
    } catch (e) {
      print(e);
    }
    ;
  }

  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        setState(() {
          print("aa");
          loggedinUser = user.email.toString();
        });

        print(loggedinUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    print("aa");
    userData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('orders').snapshots(),
        builder: (context, snapshot) {
          List<Widget> messageWidget = [];
          if (snapshot.hasData) {
            final details = snapshot.data!.docs;
            for (var detail in details) {
              print('hello' + detail['userName']);
              print('hello' + username);

              print('jhbfghjdbvsbh' + detail['userNumber']);

              if (detail['userName'] == username) {
                messageWidget.add(Orders(
                    name: detail['Name'],
                    customerName: detail['userName'],
                    number: detail['userNumber'],
                    address: detail['userAddress'],
                    price: detail['price'],
                    url: detail['imageurl'],
                    onPressed: () {},
                    icon: null));
              }
            }
          }
          return Column(
            children: messageWidget,
          );
        });
  }
}
