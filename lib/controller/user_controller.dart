import 'package:ecommerce_frontend/Repository/UserRepository.dart';
import 'package:ecommerce_frontend/model/User.dart';

class UserController {
  UserRepository userRepository = UserRepository();

  Future<List<User>> listall() {
    return userRepository.listAllUsers();
  }

  Future<User> login(String email, String password) async {
    return await userRepository.login(email, password);
  }

  User getByID(String id) {
    User user = userRepository.getByID(id) as User;
    return user;
  }
}
