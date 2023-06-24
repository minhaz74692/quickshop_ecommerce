import 'dart:core';
import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  String name;
  String id;
  String price;
  String image;
  String status;
  String description;
  bool isFavourite;
  String category;
  ProductsModel({
    required this.name,
    required this.id,
    required this.image,
    required this.description,
    required this.isFavourite,
    required this.price,
    required this.status,
    required this.category,
  });
  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        name: json['name'],
        id: json['id'],
        description: json['description'],
        image: json['image'],
        isFavourite: json['isFavourite'],
        price: json['price'],
        status: json['status'],
        category: json['category'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'status': status,
        'name': name,
        'image': image,
        'description': description,
        'price': price,
        'isFavourite': isFavourite,
        'category': category,
      };
}
