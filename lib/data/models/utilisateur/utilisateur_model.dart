import 'package:mada_jeune/data/models/authorities/authority_model.dart';
import 'package:mada_jeune/data/models/ville/ville_model.dart';

class UtilisateurModel {
  final String idUtilisateur;
  final String prenom;
  final String nom;
  final VilleModel ville;
  final String adresse;
  final String contact;
  final String mail;
  final String motDePasse;
  final int role;
  final int etat;
  final bool enabled;
  final String password;
  final List<AuthorityModel> authorities;
  final String fullId;
  final String username;
  final bool accountNonExpired;
  final bool accountNonLocked;
  final bool credentialsNonExpired;

  UtilisateurModel({
    required this.idUtilisateur,
    required this.prenom,
    required this.nom,
    required this.ville,
    required this.adresse,
    required this.contact,
    required this.mail,
    required this.motDePasse,
    required this.role,
    required this.etat,
    required this.enabled,
    required this.password,
    required this.authorities,
    required this.fullId,
    required this.username,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory UtilisateurModel.fromJson(Map<String, dynamic> json) => UtilisateurModel(
    idUtilisateur: json["idUtilisateur"],
    prenom: json["prenom"],
    nom: json["nom"],
    ville: VilleModel.fromJson(json["ville"]),
    adresse: json["adresse"],
    contact: json["contact"],
    mail: json["mail"],
    motDePasse: json["motDePasse"],
    role: json["role"],
    etat: json["etat"],
    enabled: json["enabled"],
    password: json["password"],
    authorities: List<AuthorityModel>.from(json["authorities"].map((x) => AuthorityModel.fromJson(x))),
    fullId: json["fullId"],
    username: json["username"],
    accountNonExpired: json["accountNonExpired"],
    accountNonLocked: json["accountNonLocked"],
    credentialsNonExpired: json["credentialsNonExpired"],
  );

}