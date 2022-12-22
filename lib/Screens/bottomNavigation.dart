import 'package:flutter/material.dart';
import 'package:furniture/Screens/Profile.dart';
import 'package:furniture/Screens/cartScreen.dart';
import 'package:furniture/Screens/favourite.dart';

import 'mainPage.dart';

class Navigat extends StatefulWidget {
  const Navigat({Key? key}) : super(key: key);

  @override
  _NavigatState createState() => _NavigatState();
}

class _NavigatState extends State<Navigat> {
  int _currentIndex = 0;
  final tabs = [MainPage(), Cart(), Favourite(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          unselectedItemColor: Color(0xffc7c5c8),
          selectedItemColor: Colors.indigo.shade900,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
              ),
              label: 'Favourite',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: 'Profile',
            ),
          ],
        ),
        body: tabs[_currentIndex]);
  }
}
