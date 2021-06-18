// import 'package:ecommerce_frontend/view/cart/show_cart.dart';

import 'package:ecommerce_frontend/repositories/CartRepository.dart';
import 'package:ecommerce_frontend/model/Cart.dart';
import 'package:ecommerce_frontend/model/Product.dart';

class CartController {
  Future<Cart> getCart(String id) {
    var cart = new CartRepository().getCart(id);
    return cart;
    //return products as List<Product>;
  }

  Future<Cart> getCartByClientId(String clientId) {
    var cart = new CartRepository().getCartByClientId(clientId);
    return cart;
  }

  // UpdateAddOneProduct
  Future<bool> addProduct(Product product, String clientId) async {
    Cart cart = await getCartByClientId(clientId);
    //print(cart.toString());
    if (cart == null) {
      return Future<bool>.value(false);
    }
    var response = new CartRepository().addProduct(cart.id, product.id);
    return response;
  }
}
