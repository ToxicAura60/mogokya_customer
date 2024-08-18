import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.phoneNumber,
    this.photoURL,
    this.emailVerified = false,
  });

  final String id;
  final String? email;
  final String? name;
  final String? phoneNumber;
  final String? photoURL;
  final bool emailVerified;

  static const empty = User(id: '');

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'emailVerified': emailVerified,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      photoURL: map['photoURL'],
      emailVerified: map['emailVerified'],
    );
  }

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phoneNumber,
        photoURL,
        emailVerified,
      ];
}
