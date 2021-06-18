//import 'package:flutter/material.dart';

// class Product {
//   final String id;
//   final String name;
//   final double price;
//   final String provider_cnpj;
//   final String description;

//   Product(
//       {this.id, this.name, this.price, this.provider_cnpj, this.description});

//   // @override
//   // String toString() {
//   //   // TODO: implement toString
//   //   return id + name;
//   // }
// }
class Product {
  int id;
  String name;
  double price;
  String providerCnpj;
  String description;

  Product(
      {this.id, this.name, this.price, this.providerCnpj, this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    providerCnpj = json['provider_cnpj'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['provider_cnpj'] = this.providerCnpj;
    data['description'] = this.description;
    return data;
  }
}
