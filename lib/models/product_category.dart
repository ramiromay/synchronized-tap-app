class ProductCategory {

  final String category;
  final List<Product> products;

  ProductCategory({
    required this.category,
    required this.products,
  });

}


class Product {

  final String name;
  final String image;
  final String description;
  final String price;

  Product({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
  });

}