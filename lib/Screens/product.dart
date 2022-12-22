import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;
  final VoidCallback onPressed;
  final String label;
  const Product(
      {Key? key,
      required this.name,
      required this.image,
      required this.price,
      required this.onPressed,
      required this.description,
      required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffececec),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30),
              child: Container(
                  height: MediaQuery.of(context).size.height / 2.5,
                  child: Image.network(image)),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    30.0,
                  ),
                  topRight: Radius.circular(
                    30.0,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          "$description",
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Rs.$price/-",
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w600)),
                        MaterialButton(
                          onPressed: onPressed,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.indigo.shade900,
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: Text(label,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
