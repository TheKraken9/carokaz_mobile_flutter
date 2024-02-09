class PlaceModel {
  final int idPlace;
  final int valeur;
  final int etat;
  final String nomPlace;

  PlaceModel({
    required this.idPlace,
    required this.valeur,
    required this.etat,
    required this.nomPlace,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
    idPlace: json["idPlace"],
    valeur: json["valeur"],
    etat: json["etat"],
    nomPlace: json["nomPlace"],
  );
}