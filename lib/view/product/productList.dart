import 'package:ecommerce_frontend/controller/Product.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../model/Product.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Produtos de demonstracao',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: new ProductListPage(title: 'Products'),
      home: new ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  //ProductListPage({Key key}) : super(key: key);
  @override
  _ProductListPageState createState() => new _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final Future<List<Product>> products = new ProductController().get_all();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //title: new Text(widget.title),
        title: new Text('produtoss'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //Coloca tela form por cima, e depois remove da pilha de telas
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              })
        ],
        //actions: <Widget>[IconButton(icon: Icon(Icons.delete),onPressed: () => confirmDelete(context),),],
      ),
      body: Container(
        child: FutureBuilder(
          future: products,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              //if (snapshot.connectionState == ConnectionState.done) {
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
                    subtitle: Text("Preço: " + data.price.toString()),
                    trailing: Container(
                        width: 100,
                        child: Row(
                          children: <Widget>[
                            IconButton(
                                icon: new Icon(Icons.edit),
                                color: Colors.orange,
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.PRODUCT_FORM,
                                      arguments: data);
                                }),
                            IconButton(
                                icon: new Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {})
                          ],
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => DetailPage(data)));
                      //builder: (context) => DetailPage(product: data)));
                    },
                  ));
                },
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

// card que lista
class DetailPage extends StatelessWidget {
  final Product product;
  //const ProductTile(this.product);
  DetailPage(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Container(
          child: Text(product.price.toString()),
        ));
  }
}

class FormProduct {
  final Product product;

  FormProduct(this.product);

  bool edit() {
    return false;
  }

  bool put() {
    /*
    var inputs = {
      'name': 'kaio',
      'price': 334,
      'provider_cnpj': '234234',
      'description': 'zzzzzzzzzzzzzz',
    };
    var product = new Product(
        name: inputs['name'],
        price: inputs['price'],
        provider_cnpj: inputs['provider_cnpj'],
        description: inputs['description']);

    //notifyListeners(); // atualiza a tela
    return new ProductController().put(product);
    */
    return false;
  }
}
