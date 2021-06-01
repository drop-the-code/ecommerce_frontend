//import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/Repository/Product.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String provider_cnpj;
  final String description;

  Product( {this.id, this.name, this.price, this.provider_cnpj, this.description});
}
