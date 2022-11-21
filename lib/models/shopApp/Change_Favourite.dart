class ChangeFavoritesModel
{
  late bool status;
  String? message;

  ChangeFavoritesModel(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}