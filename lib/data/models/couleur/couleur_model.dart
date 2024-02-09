class CouleurModel {
  final int idCouleur;
  final String nomCouleur;
  final int etat;

  CouleurModel({
    required this.idCouleur,
    required this.nomCouleur,
    required this.etat,
  });

  factory CouleurModel.fromJson(Map<String, dynamic> json) => CouleurModel(
    idCouleur: json["idCouleur"],
    nomCouleur: json["nomCouleur"],
    etat: json["etat"],
  );
}