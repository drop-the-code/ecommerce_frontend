import 'package:ecommerce_frontend/controller/user_controller.dart';
import 'package:flutter/material.dart';

class UserListPage extends StatelessWidget {
  final UserController userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        child: FutureBuilder(
            future: userController.listall(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var data = snapshot.data[index];
                      return Card(
                          child: ListTile(
                        title: Text(
                          data.name,
                          style: TextStyle(fontSize: 18),
                        ),
                      ));
                    });
              }
            }),
      ),
    ));
  }
}
