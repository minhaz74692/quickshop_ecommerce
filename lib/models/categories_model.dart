import 'dart:core';
import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  String name;
  String id;
  String image;
  CategoryModel({
    required this.name,
    required this.id,
    required this.image,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json['name'],
        id: json['id'],
        image: json['image'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };
}
