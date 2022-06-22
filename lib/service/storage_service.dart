import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instanceFor(bucket: "gs://flutter-app-d8260.appspot.com");

  Future<String?> uploadFile(File file, {required String name}) async {
    final snapshot = await _storage.ref(name).child(const Uuid().v4()).putFile(file);
    return await snapshot.ref.getDownloadURL();
  }
}
