import 'package:app/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  Future<UserData> getUser() async {
    final CollectionReference collection = FirebaseFirestore.instance.collection('users/' + FirebaseAuth.instance.currentUser!.uid + '/user');

    final result = await collection.get();
    final value = UserData.fromJson(result.docs.first.data());
    return value;
  }
}
