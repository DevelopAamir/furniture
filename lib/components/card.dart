import 'package:flutter/material.dart';

class Cards extends StatelessWidget {
  final String price;
  final String url;
  final String type;
  final Icon icon;
  final VoidCallback onIconTap;
  final VoidCallback onButtonTap;
  final VoidCallback onBodyTap;
  final String buttonLabel;
  const Cards({
    Key? key,
    required this.type,
    required this.price,
    required this.icon,
    required this.onIconTap,
    required this.buttonLabel,
    required this.onButtonTap,
    required this.onBodyTap,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: onBodyTap,
                child: Container(
                  child: Image.network(url, width: 130, height: 130.0),
                  decoration: BoxDecoration(
                    color: Color(0xffececec),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: 130,
                  height: 130.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 30),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.23,
                          child: Text("$type",
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.w800)),
                        ),
                        IconButton(onPressed: onIconTap, icon: icon)
                      ],
                    ),
                    Text("Rs.$price",
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: onButtonTap,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade900,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text("$buttonLabel",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
