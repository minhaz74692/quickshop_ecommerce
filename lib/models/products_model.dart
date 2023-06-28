import 'dart:core';
import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  String name;
  String id;
  double price;
  String image;
  String status;
  String description;
  bool isfavourite;
  // String category;
  ProductsModel({
    required this.name,
    required this.id,
    required this.image,
    required this.description,
    required this.isfavourite,
    required this.price,
    required this.status,
    // required this.category,
  });
  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json['name'],
        id: json['id'],
        description: json['description'] ?? json['name'],
        image: json['image'] ??
            'https://upload.wikimedia.org/wikipedia/commons/a/a7/Blank_image.jpg',
        isfavourite: json['isfavourite'] ?? true,
        price: double.parse(json['price'].toString()),
        status: json['status'] ?? '',
        // category: json['category'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'isfavourite': isfavourite,
        // 'category': category,
      };
}
