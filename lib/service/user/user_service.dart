import 'package:app/models/user/details/user_details.dart';
import 'package:app/models/user/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  Future<UserData> getUser() async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users/' + FirebaseAuth.instance.currentUser!.uid + '/user');

    final result = await collection.get();
    final id = result.docs.first.id;
    final value = UserData(id: id, details: UserDetails.fromJson(result.docs.first.data()));
    return value;
  }

  Future<void> switchPremium({
    required String email,
    required String id,
    required bool isPremium,
  }) async {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection('users/' + FirebaseAuth.instance.currentUser!.uid + '/user');
    await collection.doc(id).set(UserDetails(email: email, isPremium: isPremium).toJson());
  }
}
