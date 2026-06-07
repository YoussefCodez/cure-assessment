class UserEntity {
  final String id;
  final String name;
  final String email;
  final String token;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, name: $name, email: $email, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserEntity &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      token.hashCode;
  }
}
