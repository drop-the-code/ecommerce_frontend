// import 'package:ecommerce_frontend/view/cart/show_cart.dart';

import 'package:ecommerce_frontend/Repository/CartRepository.dart';
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
    // return products as List<Product>;
  }

  // UpdateAddOneProduct
  Future<bool> addProduct(Product product, String clientId) async {
    Cart cart = await getCartByClientId(clientId);
    //print(cart.toString());
    if (cart == null) {
      return false;
    }
    var error = new CartRepository().addProduct(cart.id, product.id);
    return true;
  }
}
