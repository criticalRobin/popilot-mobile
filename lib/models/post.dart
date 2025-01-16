import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PostModel {
  final String title;
  final String description;
  final String? imageUrl;
  final List<int> socialNetworks;
  final DateTime? createdAt;
  final DateTime? scheduledAt;

  PostModel({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.socialNetworks,
    this.createdAt,
    this.scheduledAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
