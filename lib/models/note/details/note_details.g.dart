// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteDetails _$$_NoteDetailsFromJson(Map<String, dynamic> json) =>
    _$_NoteDetails(
      title: json['title'] as String,
      description: json['description'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$_NoteDetailsToJson(_$_NoteDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'created': instance.created.toIso8601String(),
    };
