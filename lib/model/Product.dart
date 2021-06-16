//import 'package:flutter/material.dart';

class Product {
  final int id;
  final String name;
  final double price;
  final String provider_cnpj;
  final String description;

  Product(
      {this.id, this.name, this.price, this.provider_cnpj, this.description});

  // @override
  // String toString() {
  //   // TODO: implement toString
  //   return id + name;
  // }
}
