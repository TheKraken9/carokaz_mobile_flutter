class EnergieModel {
  final int idEnergie;
  final String nomEnergie;
  final int etat;

  EnergieModel({
    required this.idEnergie,
    required this.nomEnergie,
    required this.etat,
  });

  factory EnergieModel.fromJson(Map<String, dynamic> json) => EnergieModel(
    idEnergie: json["idEnergie"],
    nomEnergie: json["nomEnergie"],
    etat: json["etat"],
  );
}