class FavoritesProductModel{
  bool ?status;
  String? message;
  FavoritesProductModel.fromJson(json){
    status=json['status'];
    message=json['message'];
  }
}