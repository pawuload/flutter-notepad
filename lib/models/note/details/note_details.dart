import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_details.freezed.dart';

part 'note_details.g.dart';

@freezed
class NoteDetails with _$NoteDetails {
  factory NoteDetails({
    required String title,
    required String description,
    required DateTime created,
    required String? imageUrl,
    required String? url,
  }) = _NoteDetails;

  factory NoteDetails.fromJson(Map<String, dynamic> json) => _$NoteDetailsFromJson(json);
}
