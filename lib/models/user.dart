//TODO: improve singleton. Currently, if the _uid or _name fields havent been initialized the ram reference is returned

class User {
  static final User _instance = User._internal();
  factory User() => _instance;
  User._internal();

  String? _uid;
  String? _name;

  String? get uid => _uid;
  String? get name => _name;

  void setUid(String? uid) => _uid = uid;
  void setName(String? name) => _name = name;
}
