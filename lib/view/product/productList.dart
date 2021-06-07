import 'package:ecommerce_frontend/controller/CartController.dart';
import 'package:ecommerce_frontend/controller/Product.dart';
import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/user_store.dart';
import 'package:flutter/material.dart';
import '../../model/Product.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => new _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final Future<List<Product>> products = new ProductController().get_all();
  UserStore userStore = UserSession.instance;
  User user;
  @override
  void initState() {
    super.initState();
    this.user = userStore.getUser();
  }

  //print(user.role);

  @override
  Widget build(BuildContext context) {
    //User user;
    //String userId = user.id;
    String userId = '2';
    List<Widget> buttonPerUser(Product product) {
      //if (product.user.type == 'funcionario') {
      if (this.user.role == "funcionario") {
        return [
          IconButton(
              icon: new Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              }),
          IconButton(
              icon: new Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir usuario'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () async {
                                bool error = await new ProductController()
                                    .delete(product.id);
                                print(error);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              })
        ];
      } else {
        return [
          IconButton(
              icon: new Icon(Icons.add_shopping_cart),
              color: Colors.green,
              onPressed: () async {
                bool error =
                    await new CartController().addProduct(product, userId);
                print(error);
              }),
        ];
      }
    }

    List<Widget> meunuButtonPerUser() {
      if (this.user.role == "funcionario") {
        return [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //Coloca tela form por cima, e depois remove da pilha de telas
                Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
              }),
        ];
      } else {
        return [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.CART);
              }),
          IconButton(
              icon: new Icon(Icons.attach_money),
              color: Colors.yellowAccent,
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Finalizar compra'),
                          content: Text('Tem certeza?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () async {
                                //bool error = await new ProductController().finalShop(product.id);
                                //print(error);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              })
        ];
      }
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Produtos'),
        actions: meunuButtonPerUser(),
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
                          children: buttonPerUser(data),
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

// detalhes de um produto
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Descrição: ${product.description}",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                "Preço: ${product.price}",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Text(
                "CNPJ do fornecedor: ${product.provider_cnpj}",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ));
  }
}

//Text(product.price.toString()),
