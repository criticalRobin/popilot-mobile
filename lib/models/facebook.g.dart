// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookModel _$FacebookModelFromJson(Map<String, dynamic> json) =>
    FacebookModel(
      pageId: json['page_id'] as String,
      pageAccessToken: json['page_access_token'] as String,
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      socialNetworkType: json['social_network_type'] as String,
      createdAt: json['created_at'] as String?,
      status: json['status'] as bool?,
      userOwner: (json['user_owner'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FacebookModelToJson(FacebookModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'social_network_type': instance.socialNetworkType,
      'created_at': instance.createdAt,
      'status': instance.status,
      'user_owner': instance.userOwner,
      'page_id': instance.pageId,
      'page_access_token': instance.pageAccessToken,
    };
