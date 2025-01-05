// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_networks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialNetworksResponseModel _$SocialNetworksResponseModelFromJson(
        Map<String, dynamic> json) =>
    SocialNetworksResponseModel(
      facebookAccounts: (json['facebook_accounts'] as List<dynamic>)
          .map((e) => FacebookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      xAccounts: (json['x_accounts'] as List<dynamic>)
          .map((e) => XModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
