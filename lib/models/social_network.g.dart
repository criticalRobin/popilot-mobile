// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_network.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialNetworkModel _$SocialNetworkModelFromJson(Map<String, dynamic> json) =>
    SocialNetworkModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
      socialNetworkType: json['social_network_type'] as String,
      createdAt: json['created_at'] as String?,
      status: json['status'] as bool?,
      userOwner: (json['user_owner'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SocialNetworkModelToJson(SocialNetworkModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'social_network_type': instance.socialNetworkType,
      'created_at': instance.createdAt,
      'status': instance.status,
      'user_owner': instance.userOwner,
    };
