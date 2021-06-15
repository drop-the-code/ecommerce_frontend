import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';

class ProductRepository {
  Dio _dio = Dio();

  Future<List<Product>> getAll() async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    List<Product> products = [];
    try {
      var response = await _dio.get('http://localhost:3000/product',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
      for (var u in response.data) {
        Product product = new Product(
            id: u["id"].toString(),
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

  Future<Product> getById(String productId) async {
    //SelectByID no microServico
    Product product;
    try {
      var response = await _dio.get("http://localhost:3000/product/$productId");
      //await Dio().get('http://localhost:3000/product',queryParameters: {'id': productId});
      //await Dio().get('http://localhost:3000/product?id=' + productId);
      //print(response.data.toString());
      var data = response.data;
      product = new Product(
          id: data.id,
          name: data.name,
          description: data.description,
          price: data.price,
          provider_cnpj: data.provider_cnpj);
    } catch (e) {
      print(e);
    }
    return product;
  }

  Future<bool> post(Product product) async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    try {
      var response = await _dio.post('http://localhost:3000/product',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}),
          data: {
            'id': product.id,
            'name': product.name,
            'price': product.price,
            'provider_cnpj': product.provider_cnpj,
            'description': product.description,
          });
      if (response.data == null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> put(Product product) async {
    try {
      String id = product.id;
      var response = await _dio.put("http://localhost:3000/product/$id", data: {
        'id': id,
        'name': product.name,
        'price': product.price,
        'provider_cnpj': product.provider_cnpj,
        'description': product.description,
      });
      if (response.data == null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> delete(String id) async {
    try {
      var response = await _dio.delete("http://localhost:3000/product/$id");
      if (response.data == null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
}
