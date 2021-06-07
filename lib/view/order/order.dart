import 'package:ecommerce_frontend/model/Order.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Pagamento',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new PayPage(),
    );
  }
}

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => new _PayPageState();
}

class _PayPageState extends State<PayPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //title: new Text(widget.title),
        title: new Text('Carrinho'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.payment), onPressed: () {})
        ],
      ),
      body: Container(
        child: StreamBuilder<Order>(
          //future: order,
          //stream: order,
          //streamController: ,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return Card(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ID do cliente: ${data.client.id}",
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Text(
                      "Lista de produtos: ${data.cart}",
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
