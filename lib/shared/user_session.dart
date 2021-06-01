import 'package:ecommerce_frontend/shared/user_store.dart';

class UserSession {
  static UserStore _userStore = UserStore();

  static UserStore get instance => _userStore;
}
