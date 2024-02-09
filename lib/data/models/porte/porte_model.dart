class PorteModel {
  final int idPorte;
  final int valeur;
  final int etat;
  final String nomPorte;

  PorteModel({
    required this.idPorte,
    required this.valeur,
    required this.etat,
    required this.nomPorte,
  });

  factory PorteModel.fromJson(Map<String, dynamic> json) => PorteModel(
    idPorte: json["idPorte"],
    valeur: json["valeur"],
    etat: json["etat"],
    nomPorte: json["nomPorte"],
  );
}