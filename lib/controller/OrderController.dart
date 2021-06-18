import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/repositories/OrderRepository.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';

class OrderController {
  Future<bool> finalShop() async {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    String userId = user.id;
    var cart = await new CartController().getCartByClientId(userId);
    var response = new OrderRepository().finalShop(cart.id);
    return response;
  }
}
