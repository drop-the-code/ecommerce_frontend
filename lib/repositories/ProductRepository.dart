import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';

class ProductRepository {
  Dio _dio = Dio();

  Future<List<Product>> getAll() async {
    List<Product> products = [];
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
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
    Product product;
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await _dio.get("http://localhost:3000/product/$productId",
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
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
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
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
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      String id = product.id;
      var response = await _dio.put("http://localhost:3000/product/$id",
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}),
          data: {
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
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await _dio.delete("http://localhost:3000/product/$id",
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
      if (response.data == null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
}
