class Product {
  final String image;
  final String name;
  final String price;
  final String description;
  final String category;
  final int stock;
  final List<String> sizes;

  Product({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.stock,
    required this.sizes,
  });

  factory Product.example() {
    return Product(
      image: 'assets/images/product-ex.jpeg',
      name: 'Fashion Item',
      price: '10000',
      description: 'Description of the fashion item',
      category: 'Category',
      stock: 10,
      sizes: ['S', 'M', 'L'],
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      image: json['image'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      stock: json['stock'],
      sizes: List<String>.from(json['sizes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'stock': stock,
      'sizes': sizes,
    };
  }
}
