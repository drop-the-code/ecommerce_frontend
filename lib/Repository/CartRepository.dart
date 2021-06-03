import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Cart.dart';

class CartRepository {
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
