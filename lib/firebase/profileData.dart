import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:furniture/components/detailBubble.dart';

import 'dataManager.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({Key? key}) : super(key: key);

  @override
  _ProfileDataState createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  String loggedinUser = '';
  final _firestore = FirebaseFirestore.instance;

  void getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        setState(() {
          loggedinUser = user.email.toString();
          print("aa");
        });

        print(loggedinUser);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    print("aa");
    getCurrentUser();
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(loggedinUser).snapshots(),
        builder: (context, snapshot) {
          List<Widget> messageWidget = [];
          if (snapshot.hasData) {
            final details = snapshot.data!.docs;
            for (var detail in details) {
              print(detail['Name']);
              print(detail['address']);
              print(detail['Number']);

              messageWidget.add(detailBubble(
                detail: detail,
                string: 'Name',
              ));
              messageWidget.add(detailBubble(
                detail: detail,
                string: 'address',
              ));
              messageWidget.add(detailBubble(detail: detail, string: 'Number'));
            }
          }
          return Column(
            children: messageWidget,
          );
        });
  }
}
