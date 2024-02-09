class BoiteModel {
  final int idBoite;
  final String nomBoite;
  final int etat;

  BoiteModel({
    required this.idBoite,
    required this.nomBoite,
    required this.etat,
  });

  factory BoiteModel.fromJson(Map<String, dynamic> json) => BoiteModel(
    idBoite: json["idBoite"],
    nomBoite: json["nomBoite"],
    etat: json["etat"],
  );
}