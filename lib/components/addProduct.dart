import 'package:flutter/material.dart';
import 'package:furniture/Screens/admin.dart';

class AddProduct extends StatelessWidget {
  final String type;
  const AddProduct({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
            Text("Add $type"),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Add(
                              catogary: type,
                            )),
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
