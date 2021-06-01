import 'package:ecommerce_frontend/Repository/Product.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class ProductController {
  Future<List<Product>> get_all() {
    var products = new ProductRepository().getAll();
    return products;
    //return products as List<Product>;
  }

  Future<bool> put(Product product) {
    if (product == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().put(product);
  }
}
