// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'x.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

XModel _$XModelFromJson(Map<String, dynamic> json) => XModel(
      accessKey: json['access_key'] as String,
      accessSecret: json['access_secret'] as String,
      consumerKey: json['consumer_key'] as String,
      consumerSecret: json['consumer_secret'] as String,
      bearerToken: json['bearer_token'] as String,
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      socialNetworkType: json['social_network_type'] as String,
      createdAt: json['created_at'] as String?,
      status: json['status'] as bool?,
      userOwner: (json['user_owner'] as num?)?.toInt(),
    );

Map<String, dynamic> _$XModelToJson(XModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'social_network_type': instance.socialNetworkType,
      'created_at': instance.createdAt,
      'status': instance.status,
      'user_owner': instance.userOwner,
      'access_key': instance.accessKey,
      'access_secret': instance.accessSecret,
      'consumer_key': instance.consumerKey,
      'consumer_secret': instance.consumerSecret,
      'bearer_token': instance.bearerToken,
    };
