class MarqueModel {
  final int idMarque;
  final String nomMarque;
  final int etat;

  MarqueModel({
    required this.idMarque,
    required this.nomMarque,
    required this.etat,
  });

  factory MarqueModel.fromJson(Map<String, dynamic> json) => MarqueModel(
    idMarque: json["idMarque"],
    nomMarque: json["nomMarque"],
    etat: json["etat"],
  );
}