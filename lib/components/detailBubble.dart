import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class detailBubble extends StatelessWidget {
  final String string;
  const detailBubble({
    Key? key,
    required this.detail,
    required this.string,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> detail;

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
        child: Text(detail[string].toString()),
      ),
    );
  }
}
