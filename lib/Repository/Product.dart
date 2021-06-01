import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class ProductRepository {
  Future<List<Product>> getAll() async {
    List<Product> products = [];
    try {
      var response = await Dio().get('http://localhost:3000/products');
      for (var u in response.data) {
        Product product = new Product(
            name: u["name"],
            price: u["price"] as double,
            provider_cnpj: u["provider_cnpj"],
            description: u["description"]);
        products.add(product);
      }
    } catch (e) {
      print(e);
    }
    return products;
  }

  Future<bool> put(Product product) async {
    try {
      var response = await Dio().post('http://localhost:3000/products', data: {
        'name': product.name,
        'price': product.price,
        'provider_cnpj': product.provider_cnpj,
        'description': product.description,
      });
      if (response.data != null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
}
