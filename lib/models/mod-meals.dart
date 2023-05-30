import 'dart:ffi';

class Meals {
  String? id;
  String? categories_id;
  String? name;
  String? price;
  String? image;

  Meals({
    this.id,
    this.categories_id,
    required this.name,
    required this.price,
    required this.image,
  });

  Meals.fromMap(Map map) {
    id = map['id'];
    categories_id = map['categories_id'];
    name = map['name'];
    price = map['price'];
    image = map['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categories_id': categories_id,
      'name': name,
      'price': price,
      'image': image,
    };
  }
}
