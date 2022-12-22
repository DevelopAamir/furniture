import 'package:flutter/material.dart';

import 'package:furniture/firebase/dataManager.dart';

class All extends StatelessWidget {
  final String type;
  const All({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            Streambuild(
              icon: Icons.favorite,
              catogary: type,
              labelText: 'Add To Cart',
              task: 'favorite',
            ),
          ],
        ));
  }
}
