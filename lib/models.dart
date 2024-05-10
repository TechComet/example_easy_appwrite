import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

class BaseModel<T> {
  final int total;
  final List<T> documents;

  BaseModel({required this.total, required this.documents});
}

@JsonSerializable()
class TopicModel {
  final String title;
  final String author;

  TopicModel(
      {required this.title, required this.author});

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
  Map<String, dynamic> toJson() => _$TopicModelToJson(this);
}

@JsonSerializable()
class ReplyModel {
  final String content;
  final String author;

  ReplyModel({required this.content, required this.author});

  factory ReplyModel.fromJson(Map<String, dynamic> json) =>
      _$ReplyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyModelToJson(this);
}
