import 'package:flutter/material.dart';
import 'package:furniture/firebase/dataManager.dart';

class Cart extends StatefulWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String loggedinUser = '';
  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        setState(() {
          loggedinUser = user.email.toString();
        });

        print('aaaaaaaaaaaaaaaaa' + loggedinUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffececec),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Cart",
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: <Widget>[
                    Streambuild(
                        icon: Icons.delete,
                        catogary: 'cart$loggedinUser',
                        labelText: 'Order',
                        task: 'delete')
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
