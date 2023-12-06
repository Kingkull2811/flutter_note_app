import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_app/util/enum/note_type.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  const factory NoteModel({
    String? title,
    String? content,
    String? createAt,
    String? lastEditAt,
    String? folderName,
    int? contentFontSize,
    String? contentColor,
    String? contentStyle,
    @Default(false) bool hasLink,
    @Default(false) bool hasImage,
    NoteType? type,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);
}
