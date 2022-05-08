import 'package:app/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  Future<UserData> getUser() async {
    final CollectionReference collection = FirebaseFirestore.instance.collection('users/' + FirebaseAuth.instance.currentUser!.uid);

    final result = await collection.get();
    final value = result.docs.map((e) => UserData.fromJson(e.data()));
    return value as Future<UserData>;
  }
}
