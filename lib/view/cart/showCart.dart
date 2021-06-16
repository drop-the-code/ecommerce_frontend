import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../model/Cart.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class Cart_show extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Produtos de demonstracao',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => new _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Future<Cart> cart = new CartController().getCart('1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Carrinho'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_LIST);
              })
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: cart,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Card(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      "Lista de produtos: ${data.productListId}",
                      //Text(cart.productListId.toString()),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ));
            } else {
              return Container(child: Center(child: Text("Loading...")));
            }
          },
        ),
      ),
    );
  }
}
