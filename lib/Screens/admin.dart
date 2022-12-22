import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:furniture/Screens/logIn.dart';
import 'package:furniture/components/addProduct.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture/firebase/dataManager.dart';
import 'package:furniture/firebase/ordereddata.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'bottomNavigation.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffececec),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            "Manage orders",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Navigat()),
                              );
                            },
                            icon: Icon(Icons.home, color: Colors.black87))
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ListView(
                            physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            children: <Widget>[
                              Column(children: <Widget>[OrderedData()])
                            ])),
                    Text(
                      "Add Products",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 80.0,
                      child: ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: [
                              AddProduct(
                                type: 'Chairs',
                              ),
                              AddProduct(
                                type: 'Table',
                              ),
                              AddProduct(
                                type: 'Daraz',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text('Manage products',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800)),
                    Container(
                        padding: EdgeInsets.all(5.0),
                        height: MediaQuery.of(context).size.height * 0.43,
                        width: double.infinity,
                        child: ListView(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            Streambuild(
                              catogary: 'Chairs',
                              labelText: 'update',
                              task: 'delete',
                              icon: Icons.delete,
                            ),
                            Streambuild(
                              catogary: 'Table',
                              labelText: 'update',
                              task: 'delete',
                              icon: Icons.delete,
                            ),
                            Streambuild(
                              catogary: 'Daraz',
                              labelText: 'update',
                              task: 'delete',
                              icon: Icons.delete,
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class Add extends StatefulWidget {
  final String catogary;
  final id;
  final task;

  const Add({Key? key, required this.catogary, this.id, this.task})
      : super(key: key);
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final nameEditingController = TextEditingController();

  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;

  late XFile image;
  String fileName = '';

  String name = '';

  String price = '';

  bool spin = false;

  String downloadUrl = '';

  String description = '';

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      try {
        final selectedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        setState(() {
          image = selectedImage!;
          fileName = path.basename(image.path);
        });
      } catch (e) {}
    }

    Widget spinner() {
      if (spin == true) {
        return SpinKitDualRing(
          color: Colors.black,
          size: 50.0,
        );
      } else {
        return Container();
      }
    }

    Future<void> uploadImage() async {
      if (name != '' && price != '' && fileName != '' && description != '') {
        try {
          setState(() {
            spin = true;
          });

          Reference ref = FirebaseStorage.instance.ref().child(fileName);
          await ref.putFile(File(image.path));
          var downloadURL = await ref.getDownloadURL();

          Fluttertoast.showToast(msg: 'uploaded successfully');
          setState(() {
            downloadUrl = downloadURL.toString();
          });
          print(downloadURL.toString());

          _firestore.collection(widget.catogary).add({
            'Name': name,
            'price': price,
            'imageurl': downloadUrl,
            'description': description
          });

          setState(() {
            spin = false;
          });

          Navigator.pop(context);
        } catch (e) {
          setState(() {
            spin = false;
          });
          print(e.toString());
          Fluttertoast.showToast(msg: e.toString());
        }
      } else {
        Fluttertoast.showToast(msg: 'Fill all the requirements');
      }
    }

    Future<void> updateImage() async {
      if (name != '' && price != '' && fileName != '' && description != '') {
        try {
          setState(() {
            spin = true;
          });

          Reference ref = FirebaseStorage.instance.ref().child(fileName);
          await ref.putFile(File(image.path));
          var downloadURL = await ref.getDownloadURL();

          Fluttertoast.showToast(msg: 'uploaded successfully');
          setState(() {
            downloadUrl = downloadURL.toString();
          });
          print(downloadURL.toString());

          _firestore.collection(widget.catogary).doc(widget.id).update({
            'Name': name,
            'price': price,
            'imageurl': downloadUrl,
            'description': description
          }).catchError((e) {
            print(e);
          });

          setState(() {
            spin = false;
          });

          Navigator.pop(context);
        } catch (e) {
          setState(() {
            spin = false;
          });
          print(e.toString());
        }
      } else {
        Fluttertoast.showToast(msg: 'Fill all the requirements');
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //  SpinKitRotatingCircle(

                    //     color: Colors.white,
                    //     size: 50.0,
                    //   ),
                    GestureDetector(
                      onTap: getImage,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 25),
                        child: Container(
                            width: double.infinity,
                            height: 160,
                            child: fileName == ''
                                ? Center(
                                    child: Container(
                                    width: 160,
                                    height: 180,
                                    color: Color(0xffececec),
                                    child: Center(
                                      child: Text("Choose Image",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ))
                                : Center(child: Image.file(File(image.path)))),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    textField(
                        label: 'Enter Name of product',
                        onChanged: (value) {
                          name = value;
                        },
                        type: TextInputType.text,
                        controller: nameEditingController),

                    SizedBox(height: 15.0),

                    textField(
                        label: 'Enter Name of description',
                        onChanged: (value) {
                          description = value;
                        },
                        type: TextInputType.text,
                        controller: descriptionEditingController),

                    SizedBox(height: 15.0),
                    textField(
                        label: 'Enter price of product',
                        onChanged: (value) {
                          price = value;
                        },
                        type: TextInputType.text,
                        controller: priceEditingController),

                    SizedBox(height: 15.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                      ),
                      onPressed: () {
                        nameEditingController.clear();
                        priceEditingController.clear();
                        descriptionEditingController.clear();
                        if (widget.task == 'update') {
                          updateImage();
                        } else {
                          uploadImage();
                        }

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Admin()),
                        // );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        child: Text(
                          "upload",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Center(child: spinner()),
          ],
        ),
      )),
    );
  }
}
