import 'package:flutter/material.dart';

class Chips extends StatelessWidget {
  final String title;

  final Color color;
  const Chips({Key? key, required this.title, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 8.0,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color == Colors.white ? Colors.black87 : Colors.white,
          ),
        ));
  }
}
