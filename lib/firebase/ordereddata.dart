import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture/components/orders.dart';

class OrderedData extends StatefulWidget {
  const OrderedData({Key? key}) : super(key: key);

  @override
  _OrderedDataState createState() => _OrderedDataState();
}

class _OrderedDataState extends State<OrderedData> {
  final _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('orders').snapshots(),
        builder: (context, snapshot) {
          List<Widget> messageWidget = [];
          if (snapshot.hasData) {
            final details = snapshot.data!.docs;
            for (var detail in details) {
              final id = detail.id;
              print('hggggggg' + detail['Name']);
              print(detail['userName']);
              print(detail['userNumber']);

              messageWidget.add(
                Orders(
                  name: detail['Name'],
                  customerName: detail['userName'],
                  number: detail['userNumber'],
                  address: detail['userAddress'],
                  price: detail['price'],
                  url: detail['imageurl'],
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Are you sure, Order is delivered'),
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
                                      .collection('orders')
                                      .doc(id)
                                      .delete()
                                      .catchError((e) {
                                    print(e);
                                  });
                                  Navigator.pop(context);
                                  Fluttertoast.showToast(msg: 'Delivered');
                                },
                                child: Text('Yes'))
                          ],
                        );
                      },
                    );
                  },
                  icon: Icons.done,
                ),
              );
            }
          }
          return Column(
            children: messageWidget,
          );
        });
  }
}
