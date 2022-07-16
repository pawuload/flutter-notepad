import 'package:app/models/note/details/note_details.dart';
import 'package:app/models/note/note.dart';
import 'package:app/service/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  final AuthService _authService;

  const ItemService(this._authService);

  static const _ordering = 'created';
  static const _notes = '/notes/';

  Stream<List<Note>> itemDataStream() {
    final CollectionReference collection = FirebaseFirestore.instance.collection(_notes + _authService.user!.uid + _notes);
    return collection
        .orderBy(_ordering, descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => Note(id: e.id, details: NoteDetails.fromJson(e.data()))).toList());
  }

  Future<void> saveItem({
    required String title,
    required String description,
    required String? url,
    required List<String>? imageUrl,
    required String? videoUrl,
    required String? thumbnail,
  }) async {
    final CollectionReference collection = FirebaseFirestore.instance.collection(_notes + _authService.user!.uid + _notes);

    await collection.add(
      NoteDetails(
        title: title,
        description: description,
        created: DateTime.now(),
        url: url,
        imageUrl: imageUrl,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
      ).toJson(),
    );
  }

  Future<void> updateItem({
    required String id,
    required String title,
    required String description,
    required String? url,
    required List<String>? imageUrl,
    required String? videoUrl,
    required String? thumbnail,
  }) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(_notes + _authService.user!.uid + _notes);
    await collection.doc(id).update(
          NoteDetails(
                  title: title,
                  description: description,
                  created: DateTime.now(),
                  url: url,
                  imageUrl: imageUrl,
                  videoUrl: videoUrl,
                  thumbnail: thumbnail)
              .toJson(),
        );
  }

  Future<void> deleteItem({required String id}) async {
    CollectionReference collection = FirebaseFirestore.instance.collection(_notes + _authService.user!.uid + _notes);
    await collection.doc(id).delete();
  }
}
