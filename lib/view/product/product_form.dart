import 'package:ecommerce_frontend/controller/Product.dart';
import 'package:ecommerce_frontend/model/Product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de produto'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () async {
                //remove essa tela atual da pilha de telas, voltando para tela anterior
                //_form.currentState.validate();
                final isValid = _form.currentState.validate();

                if (isValid) {
                  _form.currentState.save();
                  print(_formData['price'].runtimeType);
                  Product product = new Product(
                      name: _formData['name'] as String,
                      price: ((_formData['price']) as double) + .0,
                      provider_cnpj: _formData['provider_cnpj'] as String,
                      description: _formData['description'] as String);
                  bool error = await new ProductController().put(product);
                  print(error);
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nome'),
                  onSaved: (value) => _formData['name'] = value,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Preço'),
                  onSaved: (value) =>
                      _formData['price'] = (double.parse(value)) + .0,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'CNPJ do fornecedor'),
                  onSaved: (value) => _formData['provider_cnpj'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Descrição'),
                  onSaved: (value) => _formData['description'] = value,
                ),
              ],
            ),
          )),
    );
  }
}
