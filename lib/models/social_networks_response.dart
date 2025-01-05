import 'package:json_annotation/json_annotation.dart';
import 'package:popilot_mobile/models/facebook.dart';
import 'package:popilot_mobile/models/x.dart';

part 'social_networks_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SocialNetworksResponseModel {
  final List<FacebookModel> facebookAccounts;
  final List<XModel> xAccounts;

  SocialNetworksResponseModel({
    required this.facebookAccounts,
    required this.xAccounts,
  });

  factory SocialNetworksResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SocialNetworksResponseModelFromJson(json);
}
