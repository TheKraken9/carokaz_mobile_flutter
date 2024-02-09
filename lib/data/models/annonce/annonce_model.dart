import 'package:intl/intl.dart';
import 'package:mada_jeune/data/models/photo/photo_model.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/data/models/ville/ville_model.dart';
import 'package:mada_jeune/data/models/voiture/voiture_model.dart';

class AnnonceModel {
  final String idAnnonce;
  final String dateAnnonce;
  final double prix;
  final ModelVoiture voiture;
  final VilleModel ville;
  final String description;
  final int etat;
  final UtilisateurModel utilisateur;
  final List<PhotoModel> photo;

  AnnonceModel({
    required this.idAnnonce,
    required this.dateAnnonce,
    required this.prix,
    required this.voiture,
    required this.ville,
    required this.description,
    required this.etat,
    required this.utilisateur,
    required this.photo,
  });

  factory AnnonceModel.fromJson(Map<String, dynamic> json) => AnnonceModel(
    idAnnonce: json["idAnnonce"],
    dateAnnonce: json["dateAnnonce"],
    prix: json["prix"],
    voiture: ModelVoiture.fromJson(json["voiture"]),
    ville: VilleModel.fromJson(json["ville"]),
    description: json["description"],
    etat: json["etat"],
    utilisateur: UtilisateurModel.fromJson(json["utilisateur"]),
    photo: List<PhotoModel>.from(json["photo"].map((x) => PhotoModel.fromJson(x))),
  );
}