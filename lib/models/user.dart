import 'package:be_thrift/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class CustomUser {
  final String uid;
  final String name;
  final String email;
  final double? budget;
  final String photoURL;
  final Currency? currency;

  CustomUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.budget,
    required this.photoURL,
    required this.currency,
  });

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  static CustomUser? fromFirebaseUser(User? user) => (user != null)
      ? CustomUser(
          uid: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
          budget: null,
          photoURL: user.photoURL ?? '',
          currency: null,
        )
      : null;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'uid': uid,
        'name': name,
        'email': email,
        'budget': budget,
        'photoURL': photoURL,
        'currency': currency?.toJson(),
      };
}
