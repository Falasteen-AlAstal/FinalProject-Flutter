class Categories {
  String? id;
  String? name;
  String? quantity;
  String? image;

  Categories({
    this.id,
    required this.name,
    required this.quantity,
    required this.image,
  });

  Categories.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    quantity = map['quantity'];
    image = map['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'image': image,
    };
  }
}
