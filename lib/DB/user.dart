final String tableUsers = 'users';

class Userfiled {
  static final List<String> values = [id, username, password, phone, phone2, firstName, lastName];
  static final String id = '_id';
  static final String username = 'username';
  static final String password = 'password';
  static final String phone = 'phone';
  static final String phone2 = 'phone2';
  static final String firstName = 'firstName';
  static final String lastName = 'lastName';
}

class User {
  final int? id;
  final String username;
  final String password;
  final String phone;
  final String phone2;
  final String firstName;
  final String lastName;

  const User({
    this.id,
    required this.username,
    required this.password,
    required this.phone,
    required this.phone2,
    required this.firstName,
    required this.lastName,
  });
  static User fromJson(Map<String, Object?> json) => User(
        id: json[Userfiled.id] as int?,
        username: json[Userfiled.username] as String,
        password: json[Userfiled.password] as String,
        phone: json[Userfiled.phone] as String,
        phone2: json[Userfiled.phone2] as String,
        firstName: json[Userfiled.firstName] as String,
        lastName: json[Userfiled.lastName] as String
      );

  Map<String, Object?> toJson() => {
        Userfiled.id: id,
        Userfiled.username: username,
        Userfiled.password: password,
        Userfiled.phone: phone,
        Userfiled.phone2 : phone2,
        Userfiled.firstName : firstName,
        Userfiled.lastName : lastName
      };
  User copy({int? id}) => User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        phone2: phone2 ?? this.phone2,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );
}
