import 'package:flutter/material.dart';
import 'package:furniture/firebase/dataManager.dart';
import 'package:furniture/firebase/myOrders.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Orders"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            children: [
              MyordersData(),
            ],
          ),
        ));
  }
}
