import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const NavigationBar(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: widget.selectedIndex,
      unselectedItemColor: Color(0xffc7c5c8),
      selectedItemColor: Colors.indigo.shade900,
      onTap: widget.onItemTapped,
    );
  }
}
