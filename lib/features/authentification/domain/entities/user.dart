import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String id;
  final String email;
  final String displayName;

  User({required this.id, required this.email, required this.displayName});
}
