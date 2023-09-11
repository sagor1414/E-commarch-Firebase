// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

class CategoryModel {
  List<Catagory> catagories;

  CategoryModel({
    required this.catagories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        catagories: List<Catagory>.from(
            json["catagories"].map((x) => Catagory.fromJson(x))),
      );
}

class Catagory {
  String name;
  List<String> subcategory;

  Catagory({
    required this.name,
    required this.subcategory,
  });

  factory Catagory.fromJson(Map<String, dynamic> json) => Catagory(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );
}
