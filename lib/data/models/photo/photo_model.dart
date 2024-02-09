class PhotoModel {
  final String photo;
  final String idVoiture;

  PhotoModel({
    required this.photo,
    required this.idVoiture,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) => PhotoModel(
    photo: json["photo"],
    idVoiture: json["idVoiture"],
  );
}