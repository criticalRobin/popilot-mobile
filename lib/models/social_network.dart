import 'package:json_annotation/json_annotation.dart';

part 'social_network.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SocialNetworkModel {
  final int? id;
  final String name;
  final String socialNetworkType;
  final String? createdAt;
  final bool? status;
  final int? userOwner;

  SocialNetworkModel({
    this.id,
    required this.name,
    required this.socialNetworkType,
    this.createdAt,
    this.status,
    this.userOwner,
  });

  factory SocialNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$SocialNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$SocialNetworkModelToJson(this);
}
