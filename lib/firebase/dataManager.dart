import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/Screens/admin.dart';
import 'package:furniture/Screens/product.dart';
import 'package:furniture/components/card.dart';
import 'package:furniture/components/orders.dart';

final _firestore = FirebaseFirestore.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class Streambuild extends StatefulWidget {
  final String catogary;
  final IconData? icon;
  final String labelText;
  final String task;
  const Streambuild(
      {Key? key,
      required this.catogary,
      required this.labelText,
      required this.task,
      required this.icon})
      : super(key: key);

  @override
  _StreambuildState createState() => _StreambuildState();
}

class _StreambuildState extends State<Streambuild> {
  String loggedinUser = '';
  String username = '';
  String useraddress = '';
  String usernumber = '';

  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        if (mounted)
          setState(() {
            loggedinUser = user.email.toString();
            print("aa");
          });
      }
    } catch (e) {
      print(e);
    }
  }

  void userData() async {
    try {
      FirebaseFirestore.instance
          .collection(loggedinUser)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (mounted)
            setState(() {
              username = doc["Name"];
              useraddress = doc["address"];
              usernumber = doc["Number"].toString();
              print("aa");
            });
          print(doc["address"]);
        });
      });
    } catch (e) {
      print(e);
    }
    ;
  }

  order(name, price, image, id) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you really want to confirm, the order?'),
          content: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("UserName: $username"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Address: $useraddress"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("phone no: $usernumber"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Only cash on delivery available"),
            ),
          ]),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No'),
            ),
            TextButton(
                onPressed: () {
                  _firestore.collection('orders').add({
                    'Name': name,
                    'price': price,
                    'imageurl': image,
                    'userName': username,
                    'userAddress': useraddress,
                    'userNumber': usernumber
                  });

                  Fluttertoast.showToast(msg: "Order placed succesfully");
                  _firestore
                      .collection('cart$loggedinUser')
                      .doc(id)
                      .delete()
                      .catchError((e) {
                    print(e);
                  });
                  Navigator.pop(context);
                },
                child: Text('Yes'))
          ],
        );
      },
    );
  }

  update(id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Add(
                  catogary: widget.catogary,
                  id: id,
                  task: 'update',
                )));
  }

  @override
  void initState() {
    print("aa");
    getCurrentUser();
    userData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection(
              widget.catogary,
            )
            .snapshots(),
        builder: (context, snapshot) {
          List<Cards> messageWidget = [];
          if (snapshot.hasData) {
            final details = snapshot.data!.docs;

            for (var detail in details) {
              final id = detail.id;
              final image = detail['imageurl'];
              final name = detail['Name'];
              final price = detail['price'];
              final description = detail['description'];

              final textWidget = Cards(
                buttonLabel: widget.labelText,
                icon: Icon(widget.icon),
                onBodyTap: () {
                  if (widget.labelText == 'update') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Product(
                                description: description,
                                name: name,
                                image: image,
                                price: price,
                                onPressed: () {
                                  update(id);
                                },
                                label: 'update',
                              )),
                    );
                  }
                  if (widget.labelText == 'Order') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Product(
                                description: description,
                                name: name,
                                image: image,
                                price: price,
                                onPressed: () {
                                  order(name, price, image, id);
                                },
                                label: 'Order Now',
                              )),
                    );
                  }
                  if (widget.labelText == 'Add To Cart') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Product(
                                description: description,
                                name: name,
                                image: image,
                                price: price,
                                onPressed: () {
                                  order(name, price, image, id);
                                },
                                label: 'Order Now',
                              )),
                    );
                  }
                },
                onButtonTap: () async {
                  if (widget.labelText == 'Order') {
                    order(name, price, image, id);
                  }
                  if (widget.labelText == 'update') {
                    update(id);
                  }

                  if (widget.labelText == 'Add To Cart') {
                    _firestore.collection('cart$loggedinUser').add({
                      'Name': name,
                      'price': price,
                      'imageurl': image,
                      'description': description
                    });
                    Fluttertoast.showToast(msg: "Added to cart succesfully");
                  }
                },
                onIconTap: () {
                  if (widget.task == 'delete') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure to delete this item'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('No'),
                            ),
                            TextButton(
                                onPressed: () {
                                  _firestore
                                      .collection(widget.catogary)
                                      .doc(id)
                                      .delete()
                                      .catchError((e) {
                                    print(e);
                                  });
                                  Fluttertoast.showToast(msg: 'Deleted');
                                  Navigator.pop(context);
                                },
                                child: Text('Yes'))
                          ],
                        );
                      },
                    );
                  }

                  if (widget.task == 'favourite') {
                    _firestore.collection('favorite$loggedinUser').add({
                      'Name': name,
                      'price': price,
                      'imageurl': image,
                      'description': description
                    });
                    Fluttertoast.showToast(
                        msg: "added to favorite succesfully");
                  }
                },
                type: name,
                url: image,
                price: price,
              );
              messageWidget.add(textWidget);
            }
          }
          return Column(
            children: messageWidget,
          );
        });
  }
}
