import 'package:mada_jeune/data/models/boite/boite_model.dart';
import 'package:mada_jeune/data/models/categorie/categorie_model.dart';
import 'package:mada_jeune/data/models/couleur/couleur_model.dart';
import 'package:mada_jeune/data/models/energie/energie_model.dart';
import 'package:mada_jeune/data/models/marque/marque_model.dart';
import 'package:mada_jeune/data/models/model/model_model.dart';
import 'package:mada_jeune/data/models/place/place_model.dart';
import 'package:mada_jeune/data/models/porte/porte_model.dart';

class ModelVoiture {
  final String idVoiture;
  final CategorieModel categorie;
  final MarqueModel marque;
  final ModelModel modele;
  final EnergieModel energie;
  final BoiteModel boite;
  final double consommation;
  final PlaceModel place;
  final PorteModel porte;
  final double kilometrage;
  final CouleurModel couleur;
  final int etat;

  ModelVoiture({
    required this.idVoiture,
    required this.categorie,
    required this.marque,
    required this.modele,
    required this.energie,
    required this.boite,
    required this.consommation,
    required this.place,
    required this.porte,
    required this.kilometrage,
    required this.couleur,
    required this.etat,
  });

  factory ModelVoiture.fromJson(Map<String, dynamic> json) => ModelVoiture(
    idVoiture: json["idVoiture"],
    categorie: CategorieModel.fromJson(json["categorie"]),
    marque: MarqueModel.fromJson(json["marque"]),
    modele: ModelModel.fromJson(json["modele"]),
    energie: EnergieModel.fromJson(json["energie"]),
    boite: BoiteModel.fromJson(json["boite"]),
    consommation: json["consommation"],
    place: PlaceModel.fromJson(json["place"]),
    porte: PorteModel.fromJson(json["porte"]),
    kilometrage: json["kilometrage"],
    couleur: CouleurModel.fromJson(json["couleur"]),
    etat: json["etat"],
  );
}