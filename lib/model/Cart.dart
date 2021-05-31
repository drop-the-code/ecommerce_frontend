import 'package:flutter/material.dart';
import 'Product.dart';

class Cart {
  List<Product> productListId;
  String id;
  String updatedAt;
  String clientId;
  bool status;

  Cart(this.productListId, this.id, this.updatedAt, this.clientId, this.status);
}

var cartExamples = [
  {
    '_id': '609b6b61591ff246d532c39e',
    'listaProdutosIds': ['333', '444', '88', '88'],
    'clienteId': 'viniciusY',
    'ativo': true,
    'createdAt': '2021-05-12T05:45:05.657Z',
    'updatedAt': '2021-05-12T05:46:13.547Z',
  },
];
