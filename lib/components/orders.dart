import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  final String name;
  final String customerName;
  final String number;
  final String address;
  final String price;
  final String url;
  final IconData? icon;
  final VoidCallback onPressed;
  const Orders({
    Key? key,
    required this.name,
    required this.customerName,
    required this.number,
    required this.address,
    required this.price,
    required this.onPressed,
    required this.url,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 165.0,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Image.network(url),
                  decoration: BoxDecoration(
                      color: Color(0xffececec),
                      borderRadius: BorderRadius.circular(15.0)),
                  width: 130,
                  height: 130.0,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5.0, top: 0, bottom: 0, right: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("$name",
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        Text("Customer: $customerName",
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.w600)),
                        Text("num : $number",
                            style: TextStyle(
                                fontSize: 10.0, fontWeight: FontWeight.w600)),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text("Address : $address",
                              style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.normal)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Rs.20000/-",
                                style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600)),
                            GestureDetector(
                                onTap: onPressed,
                                child: Icon(icon, color: Colors.indigo[900]))
                          ],
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
