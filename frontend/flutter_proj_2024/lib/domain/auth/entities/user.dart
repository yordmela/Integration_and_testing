enum Role { admin, customer }

class User {
  final String id;
  final String name;
  final String email;
  final Role role;

  User({required this.id, required this.name, required this.email, required this.role});
}
