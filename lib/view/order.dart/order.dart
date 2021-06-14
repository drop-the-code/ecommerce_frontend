import 'dart:async';

import 'package:ecommerce_frontend/controller/ProductController.dart';
import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class OrderStatefulWidget extends StatefulWidget {
  @override
  _OrderStatefulWidgetState createState() => _OrderStatefulWidgetState();
}

/// This is the private State class that goes with OrderStatefulWidget.
class _OrderStatefulWidgetState extends State<OrderStatefulWidget> {
  final _streamController = StreamController<List<Product>>();
  List<String>
      productsIDs; //iniciar essa lista com o array de strings de ids de produtos do carrinho(cart)
  @override
  void initState() {
    super.initState();
    _carregaProdutos();
  }

  _carregaProdutos() async {
    List<Product> produtos =
        await new ProductController().getProductsByCart(productsIDs);
    _streamController.add(produtos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Catálogo de Produtos", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("Erro ao acessar os dados"));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        List<Product> products = snapshot.data;
        return _listView(produproductstos);
      },
    );
  }

  _listView(produtos) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: produtos != null ? produtos.length : 0,
        itemBuilder: (context, index) {
          Product p = produtos[index];

          return Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                p.name,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                p.price.toString(),
                style: TextStyle(fontSize: 20),
              )
            ],
          ));
        },
      ),
    );
  }
}
