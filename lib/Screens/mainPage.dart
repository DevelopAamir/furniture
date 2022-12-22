import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:furniture/components/all.dart';

import 'package:furniture/components/chip.dart';

import 'package:furniture/firebase/dataManager.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController searchController = TextEditingController();
  String search = 'all';
  List<String> type = [
    'Chairs',
    'Table',
    'Daraz',
  ];

  final List<Widget> _pages = <Widget>[
    new Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Streambuild(
            catogary: 'Chairs',
            labelText: 'Add To Cart',
            task: 'favourite',
            icon: Icons.favorite,
          ),
          Streambuild(
              catogary: 'Table',
              labelText: 'Add To Cart',
              task: 'favoutite',
              icon: Icons.favorite),
          Streambuild(
              catogary: 'Daraz',
              labelText: 'Add To Cart',
              task: 'favourite',
              icon: Icons.favorite),
        ],
      ),
    ),
    new All(
      type: "Chairs",
    ),
    new All(
      type: "Table",
    ),
    new All(
      type: "Daraz",
    ),
  ];
  int selectedIndex = 0;
  Color color0 = Colors.indigo.shade900;
  Color color1 = Colors.white;
  Color color2 = Colors.white;
  Color color3 = Colors.white;

  @override
  Widget build(BuildContext context) {
    setState(() {
      selectedIndex = 0;
    });

    void updatecolor(pageId) {
      if (pageId == 0) {
        setState(() {
          color0 = Colors.indigo.shade900;
          color1 = Colors.white;
          color2 = Colors.white;
          color3 = Colors.white;
        });
      }
      if (pageId == 1) {
        setState(() {
          color0 = Colors.white;
          color1 = Colors.indigo.shade900;
          color2 = Colors.white;
          color3 = Colors.white;
        });
      }
      if (pageId == 2) {
        setState(() {
          color0 = Colors.white;
          color1 = Colors.white;
          color2 = Colors.white;
          color3 = Colors.indigo.shade900;
        });
      }
      if (pageId == 3) {
        setState(() {
          color0 = Colors.white;
          color1 = Colors.white;
          color2 = Colors.indigo.shade900;
          color3 = Colors.white;
        });
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          backgroundColor: Color(0xffececec),
          body: Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "Our",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Products",
                      style: TextStyle(
                          color: Colors.indigo.shade900,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('about us'),
                                content: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Gmail: raosao@gmail.com"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        Text("Address: kathmandu/basundhara"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Phone Number: 9868768895"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Description",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("furniture app is ........"),
                                  ),
                                ]),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('OK'))
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  height: 40.0,
                  child: Theme(
                    data: ThemeData(primarySwatch: Colors.indigo),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      onSubmitted: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Search(search: value)));
                        searchController.clear();
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_outlined),
                        fillColor: Colors.white,
                        focusColor: Colors.white,
                        filled: true,
                        labelText: 'Search',
                        labelStyle: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.w300,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Chips(
                        color: color0,
                        title: "All",
                      ),
                      Chips(
                        color: color1,
                        title: "Chair",
                      ),
                      Chips(
                        color: color3,
                        title: "Table",
                      ),
                      Chips(
                        color: color2,
                        title: "Daraz",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: PageView(
                      onPageChanged: (pageId) {
                        setState(() {
                          updatecolor(pageId);
                        });
                      },
                      controller: PageController(
                        initialPage: 0,
                      ),
                      children: _pages,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class Search extends StatefulWidget {
  final String search;
  const Search({Key? key, required this.search}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    Widget all(search) {
      List<Widget> searched = [];
      if (search == 'all') {
        searched.add(Streambuild(
          catogary: 'Chairs',
          labelText: 'Add To Cart',
          task: 'favourite',
          icon: Icons.favorite,
        ));

        searched.add(Streambuild(
          catogary: 'Table',
          labelText: 'Add To Cart',
          task: 'favourite',
          icon: Icons.favorite,
        ));
        searched.add(Streambuild(
          catogary: 'Daraz',
          labelText: 'Add To Cart',
          task: 'favourite',
          icon: Icons.favorite,
        ));
      } else if (search == 'C' ||
          search == 'c' ||
          search == 'Ch' ||
          search == 'ch' ||
          search == 'Cha' ||
          search == 'cha' ||
          search == 'Chai' ||
          search == 'chai' ||
          search == 'Chair' ||
          search == 'chair' ||
          search == 'Chairs' ||
          search == 'chairs') {
        searched.add(Streambuild(
          catogary: 'Chairs',
          labelText: 'Add To Cart',
          task: 'favourite',
          icon: Icons.favorite,
        ));
      } else if (search == 'T' ||
          search == 't' ||
          search == 'Ta' ||
          search == 'ta' ||
          search == 'Tab' ||
          search == 'tab' ||
          search == 'Tabl' ||
          search == 'tabl' ||
          search == 'Table' ||
          search == 'table' ||
          search == 'Tables' ||
          search == 'tables') {
        searched.add(Streambuild(
            catogary: 'Table',
            labelText: 'Add To Cart',
            task: 'favoutite',
            icon: Icons.favorite));
      } else if (search == 'D' ||
          search == 'd' ||
          search == 'Da' ||
          search == 'da' ||
          search == 'Dar' ||
          search == 'dar' ||
          search == 'Dara' ||
          search == 'dara' ||
          search == 'Daraz' ||
          search == 'daraz' ||
          search == 'Daraz' ||
          search == 'daraz') {
        searched.add(Streambuild(
            catogary: 'Daraz',
            labelText: 'Add To Cart',
            task: 'favoutite',
            icon: Icons.favorite));
      } else {
        searched.add(Text("No result matching "));
      }
      return ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: searched);
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 25.0),
          height: 500,
          child: Column(
            children: [
              Container(
                  height: 200,
                  width: double.infinity,
                  child: all(widget.search))
            ],
          ),
        ),
      ),
    ));
  }
}
