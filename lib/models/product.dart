class Product {
  final String? id;
  final String name;
  final String description;
  final int rating;
  final int level;
  final int servings;
  final double price;
  final int points;
  final int bounus;
  final String category;
  final int sku;
  final int quantity;
  final String? photoUrl;

  Product(
    this.name,
    this.description,
    this.rating,
    this.level,
    this.servings,
    this.price,
    this.points,
    this.bounus,
    this.category,
    this.sku,
    this.quantity, {
    this.photoUrl,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> data, {String? id}) {
    return Product(
      data["name"],
      data["description"],
      data["rating"],
      data["level"],
      data["servings"],
      data["price"],
      int.parse(data["points"].toString()),
      int.parse(data["bounus"].toString()),
      data["category"],
      data["sku"],
      data["quantity"],
      id: id,
      photoUrl: data["photo"],
    );
  }

  toMap() => {
        "name": name,
        "description": description,
        "rating": rating,
        "level": level,
        "servings": servings,
        "price": price,
        "category": category,
        "sku": sku,
        "quantity": quantity,
        "photo": photoUrl,
      };

  @override
  String toString() {
    return toMap().toString();
  }
}
