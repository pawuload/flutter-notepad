import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(File file, {required String name}) async {
    final snapshot = await _storage.ref('$name').child(name).putFile(file);
    return await snapshot.ref.getDownloadURL();
  }
}
