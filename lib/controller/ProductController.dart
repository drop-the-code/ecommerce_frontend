import 'package:ecommerce_frontend/repositories/ProductRepository.dart';
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

  Future<bool> post(Product product) {
    if (product == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().post(product);
  }

  Future<bool> delete(int id) {
    //print(product.toString());
    if (id == null) {
      return Future<bool>.value(false);
    }
    return new ProductRepository().delete(id);
  }

  List<Product> getProductsByCart(List<String> productsIDs) {
    List<Product> products;
    if (productsIDs == null) {
      return products;
    }
    for (final productId in productsIDs) {
      Product product = new ProductRepository().getById(productId) as Product;
      if (product != null) {
        products.add(product);
      }
    }
    return products;
  }
}
