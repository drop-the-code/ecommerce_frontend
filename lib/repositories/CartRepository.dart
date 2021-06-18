import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';

//updateAddOneProduct
class CartRepository {
  //o microservico cart, recebe 1 productId e o add ao array de productsId
  Future<bool> addProduct(String cartId, String productId) async {
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await Dio().put('http://localhost:3000/cart/$cartId',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}),
          data: {
            'productListId': [productId],
          });
      if (response.data == null) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<Cart> getCartByClientId(String clientId) async {
    Cart cart;
    try {
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await Dio().get(
          'http://localhost:3000/cart?clientId=$clientId',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
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
      UserStore userStore = UserSession.instance;
      User user = userStore.getUser();
      var response = await Dio().get('http://localhost:3000/cart/$id',
          options: Options(headers: {"Authorization": "Bearer ${user.token}"}));
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
