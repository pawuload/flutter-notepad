// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      title: json['title'] as String,
      description: json['description'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'created': instance.created.toIso8601String(),
    };
