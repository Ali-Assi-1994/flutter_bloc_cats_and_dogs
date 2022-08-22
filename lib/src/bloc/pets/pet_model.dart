import 'dart:convert';

import 'package:dogs_and_cats/src/bloc/pets/breed_model.dart';

List<Pet> petsListFromJson(String str) => List<Pet>.from(json.decode(str).map((x) => Pet.fromJson(x)));
String petsListToJson(List<Pet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pet {
  Pet({
    this.breeds,
    required this.id,
    required this.url,
    this.width,
    this.height,
  });

  List<Breed?>? breeds;
  String id;
  String url;
  int? width;
  int? height;

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        breeds: json["breeds"] == null ? null : List<Breed>.from(json["breeds"].map((x) => Breed.fromJson(x))),
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "breeds": breeds == null ? null : List<Breed>.from(breeds!.map((x) => x)),
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
