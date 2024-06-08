import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:untitled1/models/add_user.dart';

class RealTimeDBServices {
  static Future<bool> addUser(AddUserModel addUserModel) async {
    bool res = false;
    var db = FirebaseDatabase.instance.ref();
    db
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .set(addUserModel.toJson())
        .whenComplete(() {
      res = true;
    });
    return res;
  }

  static Stream<AddUserModel?> getUser() async* {
    try {
      DataSnapshot snapshot = await FirebaseDatabase.instance
          .reference()
          .child('users')
          .child(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        Map<String, dynamic> data =
            Map<String, dynamic>.from(snapshot.value as Map);
        yield AddUserModel.fromJson(data);
      } else {
        yield null;
      }
    } catch (e) {
      print('Error user data: $e');
      yield null;
    }
  }

  static updateUser(AddUserModel addUserModel) async {
    await FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update(addUserModel.toJson());
  }
}
