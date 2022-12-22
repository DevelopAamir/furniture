import 'package:flutter/material.dart';

import 'package:furniture/firebase/dataManager.dart';

class Favourite extends StatefulWidget {
  const Favourite({
    Key? key,
  }) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  String loggedinUser = '';
  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        setState(() {
          loggedinUser = user.email.toString();
        });

        print(loggedinUser);
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
      body: Padding(
        padding: EdgeInsets.all(
          15.0,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Favourite",
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
                        catogary: 'favorite$loggedinUser',
                        labelText: 'Add To Cart',
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
