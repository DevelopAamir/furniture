import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dataManager.dart';

class Store {
  final storage = FlutterSecureStorage();
  Future<void> storeData(User? user) async {
    await storage.write(key: 'user', value: user!.email.toString());
  }

  Future<String?> getData(String key) async {
    return await storage.read(key: key);
  }

  Future<void> logOut() async {
    try {
      await storage.delete(key: 'user');
      auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
