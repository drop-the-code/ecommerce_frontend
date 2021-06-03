import 'package:ecommerce_frontend/controller/Product.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../../model/Product.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:convert';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Produtos de demonstracao',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       //home: new ProductListPage(title: 'Products'),
//       home: new ProductListPage(),
//     );
//   }
// }

class ProductListPage extends StatefulWidget {
  //ProductListPage({Key key}) : super(key: key);
  @override
  _ProductListPageState createState() => new _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final Future<List<Product>> products = new ProductController().get_all();

  @override
  Widget build(BuildContext context) {
    //User user;
    List<Widget> buttonPerUser(data) {
      if (true) {
        return [
          IconButton(
              icon: new Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: data);
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
                                    .delete(data.id);
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
              color: Colors.orange,
              onPressed: () {}),
        ];
      }
    }

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
          child: Text(product.price.toString()),
        ));
  }
}
