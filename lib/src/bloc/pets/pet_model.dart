class PetModel {
  PetModel({
    this.breeds,
    required this.id,
    required this.url,
    this.width,
    this.height,
  });

  List<dynamic>? breeds;
  String id;
  String url;
  int? width;
  int? height;

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        breeds: json["breeds"] == null ? null : List<dynamic>.from(json["breeds"].map((x) => x)),
        id: json["id"],
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "breeds": breeds == null ? null : List<dynamic>.from(breeds!.map((x) => x)),
        "id": id,
        "url": url,
        "width": width,
        "height": height,
      };
}
