import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/view/Login.dart';
import 'package:ecommerce_frontend/view/auth/Register.dart';
import 'package:ecommerce_frontend/view/errors/forbidden.dart';
import 'package:ecommerce_frontend/view/product/productList.dart';
import 'package:ecommerce_frontend/view/product/product_form.dart';
import 'package:ecommerce_frontend/view/errors/unknown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'model/User.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  static Future<User> getUser() async => await FlutterSession().get("user");

  static Widget checkAuthenticate(Widget fromPage) {
    User user = getUser() as User;
    if (user.token == null)
      return ForbiddenPage();
    else
      return fromPage;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      /*initialRoute: '/login',
      home: LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name == "/login") {
          return MaterialPageRoute(builder: (context) => LoginPage());
        }
        if (settings.name == "/register") {
          return MaterialPageRoute(builder: (context) => RegisterPage());
        }
        if (settings.name == "/listProduto") {
          return MaterialPageRoute(builder: (context) => ProductListPage());
        }
        // unknown route
        return MaterialPageRoute(builder: (_) => UnknownPage());
      },*/
      routes: {
        AppRoutes.HOME: (_) => LoginPage(),
        AppRoutes.PRODUCT_FORM: (_) => checkAuthenticate(ProductForm()),
        AppRoutes.LOGIN: (_) => LoginPage(),
        AppRoutes.PRODUCT_LIST: (_) => checkAuthenticate(ProductListPage()),
        AppRoutes.REGISTER: (_) => RegisterPage(),
      },
    );
  }
}
