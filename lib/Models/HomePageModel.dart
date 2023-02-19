class HomeModel {
  HomeModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final bool? status;
  final dynamic message;
   final DataModel? data;

  factory HomeModel.fromJson(Map<String, dynamic> json){
    return HomeModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : DataModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };

}

class DataModel {
  DataModel({
    required this.banners,
    required this.products,
    required this.ad,
  });

  final List<Banner> banners;
  final List<Product> products;
  final String? ad;

  factory DataModel.fromJson(Map<String, dynamic> json){
    return DataModel(
      banners: json["banners"] == null ? [] : List<Banner>.from(json["banners"]!.map((x) => Banner.fromJson(x))),
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
      ad: json["ad"],
    );
  }

  Map<String, dynamic> toJson() => {
    "banners": banners.map((x) => x.toJson()).toList(),
    "products": products.map((x) => x.toJson()).toList(),
    "ad": ad,
  };

}

class Banner {
  Banner({
    required this.id,
    required this.image,
    required this.category,
    required this.product,
  });

  final int? id;
  final String? image;
  final dynamic category;
  final dynamic product;

  factory Banner.fromJson(Map<String, dynamic> json){
    return Banner(
      id: json["id"],
      image: json["image"],
      category: json["category"],
      product: json["product"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "category": category,
    "product": product,
  };

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
    required this.images,
    required this.inFavorites,
    required this.inCart,
  });

  final int? id;
   var price;
   var oldPrice;
   var discount;
  final String? image;
  final String? name;
  final String? description;
  final List<String> images;
  final bool? inFavorites;
  final bool? inCart;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      price: json["price"],
      oldPrice: json["old_price"],
      discount: json["discount"],
      image: json["image"],
      name: json["name"],
      description: json["description"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      inFavorites: json["in_favorites"],
      inCart: json["in_cart"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "old_price": oldPrice,
    "discount": discount,
    "image": image,
    "name": name,
    "description": description,
    "images": images.map((x) => x).toList(),
    "in_favorites": inFavorites,
    "in_cart": inCart,
  };

}
