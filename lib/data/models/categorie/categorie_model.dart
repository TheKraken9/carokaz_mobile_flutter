class CategorieModel {
  final int idCategorie;
  final String nomCategorie;
  final int etat;

  CategorieModel({
    required this.idCategorie,
    required this.nomCategorie,
    required this.etat,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
    idCategorie: json["idCategorie"],
    nomCategorie: json["nomCategorie"],
    etat: json["etat"],
  );
}