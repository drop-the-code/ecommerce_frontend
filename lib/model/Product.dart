//import 'package:flutter/material.dart';
import 'package:ecommerce_frontend/Repository/Product.dart';

class Product {
  final String name;
  final double price;
  final String provider_cnpj;
  final String description;

  Product(
      { this.name,
       this.price,
       this.provider_cnpj,
       this.description});
}
