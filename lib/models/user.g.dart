// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomUser _$UserFromJson(Map<String, dynamic> json) {
  return CustomUser(
    uid: json['uid'] as String,
    name: json['name'] as String,
    email: json['email'] as String,
    budget: (json['budget'] as num?)?.toDouble(),
    photoURL: json['photoURL'] as String,
    currency: json['currency'] == null
        ? null
        : Currency.fromJson(json['currency'] as Map<String, dynamic>),
  );
}
