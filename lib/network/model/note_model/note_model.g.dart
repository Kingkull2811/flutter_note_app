// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NoteModel _$$_NoteModelFromJson(Map<String, dynamic> json) => _$_NoteModel(
      title: json['title'] as String?,
      content: json['content'] as String?,
      createAt: json['createAt'] as String?,
      lastEditAt: json['lastEditAt'] as String?,
      folderName: json['folderName'] as String?,
      contentFontSize: json['contentFontSize'] as int?,
      contentColor: json['contentColor'] as String?,
      contentStyle: json['contentStyle'] as String?,
      hasLink: json['hasLink'] as bool? ?? false,
      hasImage: json['hasImage'] as bool? ?? false,
      type: $enumDecodeNullable(_$NoteTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_NoteModelToJson(_$_NoteModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'createAt': instance.createAt,
      'lastEditAt': instance.lastEditAt,
      'folderName': instance.folderName,
      'contentFontSize': instance.contentFontSize,
      'contentColor': instance.contentColor,
      'contentStyle': instance.contentStyle,
      'hasLink': instance.hasLink,
      'hasImage': instance.hasImage,
      'type': _$NoteTypeEnumMap[instance.type],
    };

const _$NoteTypeEnumMap = {
  NoteType.text: 'text',
  NoteType.textImage: 'textImage',
  NoteType.listTask: 'listTask',
};
