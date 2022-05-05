import 'package:app/models/note/note.dart';
import 'package:app/service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  final AuthService _authService;
  ItemService(this._authService);

  Future<List<Note>> getAllItems() async {
    final CollectionReference collection = FirebaseFirestore.instance.collection('notes/' + _authService.user!.uid + '/notes');

    final result = await collection.get();
    final value = result.docs.map((e) => Note.fromJson(e.data()));
    return value.toList();
  }

  Future<void> saveItem({required String title, required String description}) async {
    final CollectionReference collection = FirebaseFirestore.instance.collection('notes/' + _authService.user!.uid + '/notes');

    await collection.add(Note(title: title, description: description, created: DateTime.now()).toJson());
  }
}
