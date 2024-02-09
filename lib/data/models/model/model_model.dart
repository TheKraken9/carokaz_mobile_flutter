import 'package:mada_jeune/data/models/categorie/categorie_model.dart';
import 'package:mada_jeune/data/models/marque/marque_model.dart';

class ModelModel {
  final int idModele;
  final String nomModele;
  final MarqueModel marque;
  final CategorieModel categorie;
  final int etat;

  ModelModel({
    required this.idModele,
    required this.nomModele,
    required this.marque,
    required this.categorie,
    required this.etat,
  });

  factory ModelModel.fromJson(Map<String, dynamic> json) => ModelModel(
    idModele: json["idModele"],
    nomModele: json["nomModele"],
    marque: MarqueModel.fromJson(json["marque"]),
    categorie: CategorieModel.fromJson(json["categorie"]),
    etat: json["etat"],
  );
}