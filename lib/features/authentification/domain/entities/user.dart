class User {
  final String id;
  final String email;
  final String displayName;
  String? avatar;

  User({required this.id, required this.email, required this.displayName, this.avatar});
}
