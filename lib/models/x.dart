import 'package:json_annotation/json_annotation.dart';
import 'social_network.dart';

part 'x.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class XModel extends SocialNetworkModel {
  final String accessKey;
  final String accessSecret;
  final String consumerKey;
  final String consumerSecret;
  final String bearerToken;

  XModel({
    required this.accessKey,
    required this.accessSecret,
    required this.consumerKey,
    required this.consumerSecret,
    required this.bearerToken,
    super.id,
    required super.name,
    required super.socialNetworkType,
    super.createdAt,
    super.status,
    super.userOwner,
  });

  factory XModel.fromJson(Map<String, dynamic> json) => _$XModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$XModelToJson(this);
}
