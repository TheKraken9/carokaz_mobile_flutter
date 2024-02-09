class AuthorityModel {
  final String authority;

  AuthorityModel({
    required this.authority,
  });

  factory AuthorityModel.fromJson(Map<String, dynamic> json) => AuthorityModel(
    authority: json["authority"],
  );
}