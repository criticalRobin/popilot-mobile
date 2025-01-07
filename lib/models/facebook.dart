import 'package:json_annotation/json_annotation.dart';
import 'social_network.dart';

part 'facebook.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FacebookModel extends SocialNetworkModel {
  final String pageId;
  final String pageAccessToken;

  FacebookModel({
    required this.pageId,
    required this.pageAccessToken,
    super.id,
    required super.name,
    required super.socialNetworkType,
    super.createdAt,
    super.status,
    super.userOwner,
  });

  factory FacebookModel.fromJson(Map<String, dynamic> json) =>
      _$FacebookModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FacebookModelToJson(this);
}
