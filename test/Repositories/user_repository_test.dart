import 'package:ecommerce_frontend/Repository/UserRepository.dart';
import 'package:flutter_test/flutter_test.dart';

UserRepository userRepo = UserRepository();

void main() {
  test("Login", () async {
    var user = await userRepo.login("teste@teste.com", "12345");
    expect(user.email, "teste@teste.com");
  });

  test("ListUsersFuncionando", () async {
    await userRepo.login("teste@teste.com", "12345");
    var users = await userRepo.listAllUsers();
    print(users);
    expect(users[0].email, "teste@teste5.com");
  });
}
