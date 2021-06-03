// import 'package:ecommerce_frontend/view/cart/show_cart.dart';

import 'package:ecommerce_frontend/Repository/CartRepository.dart';
import 'package:ecommerce_frontend/model/Cart.dart';

class CartController {
  Future<Cart> get_cart(String id) {
    var cart = new CartRepository().getCart(id);
    return cart;
    //return products as List<Product>;
  }
}
