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
      //home: new CartPage(title: 'carts'),
      home: new CartPage(),
    );
  }
}

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => new _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Future<Cart> cart = new CartController().get_cart('1');

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //title: new Text(widget.title),
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
                  child: ListTile(
                title: Text(
                  data.status.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text("status: " + data.status.toString()),
                trailing: Container(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            icon: new Icon(Icons.add_shopping_cart),
                            color: Colors.red,
                            onPressed: () {}),
                      ],
                    )),
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

// card de detalhes de um cart
class DetailPage extends StatelessWidget {
  final Cart cart;
  DetailPage(this.cart);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seu carrinho"),
        ),
        body: Container(
          child: Text(cart.productListId.toString()),
        ));
  }
}
