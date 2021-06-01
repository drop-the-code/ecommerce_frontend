import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  final UserController userController = UserController();
  //final Future<List<User>> listAll = UserController().listAll();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
      child: FutureBuilder<List<User>>(
          future: userController.listAll(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      title: Text(data.name),
                    ),
                  );
                });
          }),
    )));
  }
}
