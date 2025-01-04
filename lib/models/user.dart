import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String username;
  final String email;
  final bool? isPremiumUser;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.isPremiumUser,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
