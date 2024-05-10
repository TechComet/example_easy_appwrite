// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      title: json['title'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'author': instance.author,
    };

ReplyModel _$ReplyModelFromJson(Map<String, dynamic> json) => ReplyModel(
      content: json['content'] as String,
      author: json['author'] as String,
    );

Map<String, dynamic> _$ReplyModelToJson(ReplyModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'author': instance.author,
    };
