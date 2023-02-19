class FavoritesModel {
  FavoritesModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final dynamic message;
  final Data? data;
  factory FavoritesModel.fromJson(Map<String, dynamic> json){
    return FavoritesModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }
}
class Data {
  Data({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<Datum> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      currentPage: json["current_page"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      firstPageUrl: json["first_page_url"],
      from: json["from"],
      lastPage: json["last_page"],
      lastPageUrl: json["last_page_url"],
      nextPageUrl: json["next_page_url"],
      path: json["path"],
      perPage: json["per_page"],
      prevPageUrl: json["prev_page_url"],
      to: json["to"],
      total: json["total"],
    );
  }
}
class Datum {
  Datum({
    required this.id,
    required this.product,
  });
  final int? id;
  final Product? product;
  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      id: json["id"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

}
class Product {
  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });
  final int? id;
  final dynamic? price;
  final dynamic? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      price: json["price"],
      oldPrice: json["old_price"],
      discount: json["discount"],
      image: json["image"],
      name: json["name"],
      description: json["description"],
    );
  }

}
