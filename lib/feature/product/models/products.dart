class Product {
  int id;
  String name;
  String description;
  String price;
  int? quantity;
  String discount;
  int? category;
  List<ProductImage> images = <ProductImage>[];

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.discount,
    required this.category,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    int? quantity = json['quantity'];
    int? category = json['category'];
    List<ProductImage> images = <ProductImage>[];
    if (json['images'] != null) {
      json['images'].forEach((image) {
        images.add(ProductImage.fromJson(image));
      });
    }
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      quantity: quantity,
      discount: json['discount'],
      category: category,
      images: images,
    );
  }
}

class ProductImage {
  int id;
  String image;

  ProductImage({
    required this.id,
    required this.image,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      image: json['image'] ?? '',
    );
  }
}