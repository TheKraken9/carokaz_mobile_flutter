class APIResponse<T> {
  String? erreur;
  String? remarque;
  T? data;

  APIResponse({
    this.erreur = "",
    this.remarque = "",
    this.data,
  });
}