import 'package:ecommerce_frontend/Repository/Product.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class ProductController {
  Future<List<Product>> get_all() {
    var products = new ProductRepository().getAll();
    return products;
    //return products as List<Product>;
  }

  bool put(Product product) {
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    if (product == null) {
      return false;
    }
    return (new ProductRepository().put(product) as bool);
  }
}
