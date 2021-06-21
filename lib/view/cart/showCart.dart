import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:flutter/material.dart';
import '../../model/Cart.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => new _CartPageState();
}

class _CartPageState extends State<CartPage> {
  UserStore userStore = UserSession.instance;
  User user = User();
  CartController cartController = CartController();
  @override
  void initState() {
    super.initState();
    user = userStore.getUser();
    //this.cart = cartController.getCartByClientId(user.id);
  }

  void _removeProductCart(String id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Carrinho'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.PRODUCT_LIST);
              })
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: cartController.getCartByClientId(user.id),
          builder: (BuildContext context, AsyncSnapshot<Cart> snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ID do cliente: ${data.clientId}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Ultima atualização: ${data.updatedAt}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Status: ${data.status}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(data.productListId.toString())
                  ],
                ),
              );
            } else {
              return Container(child: Center(child: Text("Loading...")));
            }
          },
        ),
      ),
    );
  }
}
