import 'package:ecommerce_frontend/Repository/UserRepository.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/user_store.dart';

class UserController {
  UserRepository userRepository = UserRepository();

  Future<List<User>> listAll() {
    return userRepository.listAllUsers();
  }

  Future<User> login(String email, String password) async {
    User user = await userRepository.login(email, password);
    UserStore userStore = UserSession.instance;
    userStore.setUser(user);
    return user;
  }

  User getByID(String id) {
    User user = userRepository.getByID(id) as User;
    return user;
  }
}
