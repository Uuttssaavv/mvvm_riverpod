typedef ProductList = List<ProductModel>;

class ProductModel {
  final int? id;
  final String title;
  final String description;
  final DateTime dateAdded;

  ProductModel({
    this.id,
    required this.title,
    required this.description,
    required this.dateAdded,
  });
  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateAdded,
  }) =>
      ProductModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dateAdded: dateAdded ?? this.dateAdded,
      );

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateAdded: DateTime.parse(json["dateAdded"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "dateAdded":
            "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
      };
}
