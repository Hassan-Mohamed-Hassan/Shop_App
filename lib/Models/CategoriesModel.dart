
class CategoriesModel {
  CategoriesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final dynamic message;
  final Data? data;

  factory CategoriesModel.fromJson(Map<String, dynamic> json){
    return CategoriesModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

}
class Data {
  Data({
    required this.currentPage,
    required this.data,
  });

  final int? currentPage;
  final List<Datum> data;
  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data.map((x) => x.toJson()).toList(),
  };
}
class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };

}
