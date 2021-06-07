import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
// import 'package:ecommerce_frontend/model/Product.dart';

//updateAddOneProduct
class CartRepository {
  //o microservico cart, recebe 1 productId e o add ao array de productsId
  Future<bool> addProduct(String cartId, String productId) async {
    try {
      var response =
          await Dio().put('http://localhost:3000/carts/' + cartId, data: {
        'productListId': [productId],
      });
      if (response.data == null) {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Cart> getCartByClientId(String clientId) async {
    Cart cart;
    try {
      var response =
          await Dio().get('http://localhost:3000/carts?clientId=' + clientId);
      var data = response.data[0];
      cart = new Cart(
          productListId: data["productListId"],
          id: data["id"].toString(),
          updatedAt: data["updatedAt"],
          clientId: data["clientId"],
          status: data["status"]);
      return Future<Cart>.value(cart);
    } catch (e) {
      print(e);
    }
    return cart;
  }

  Future<Cart> getCart(String id) async {
    Cart cart;
    try {
      var response = await Dio().get('http://localhost:3000/carts/' + id);
      var data = response.data;
      cart = new Cart(
          productListId: data["productListId"],
          id: data["id"].toString(),
          updatedAt: data["updatedAt"],
          clientId: data["clientId"],
          status: data["status"]);
      return Future<Cart>.value(cart);
    } catch (e) {
      print(e);
    }
    return cart;
  }
}
