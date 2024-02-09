class VilleModel {
  final int idVille;
  final String nomVille;
  final int etat;

  VilleModel({
    required this.idVille,
    required this.nomVille,
    required this.etat,
  });

  factory VilleModel.fromJson(Map<String, dynamic> json) => VilleModel(
    idVille: json["idVille"],
    nomVille: json["nomVille"],
    etat: json["etat"],
  );
}