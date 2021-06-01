import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/view/Login.dart';
import 'package:ecommerce_frontend/view/auth/Register.dart';
import 'package:ecommerce_frontend/view/errors/forbidden.dart';
import 'package:ecommerce_frontend/view/product/productList.dart';
import 'package:ecommerce_frontend/view/product/product_form.dart';
import 'package:ecommerce_frontend/view/errors/unknown.dart';
import 'package:ecommerce_frontend/view/user/ListUser.dart';
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
    if (user.token == null) {
      print("aqui");
      return ForbiddenPage();
    } else {
      return fromPage;
    }
  }

  static Widget checkFuncionarioAuthenticate(Widget fromPage) {
    User user = getUser() as User;
    if (user.token == null && user.role == 'funcionario') {
      return ForbiddenPage();
    } else {
      return fromPage;
    }
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
      initialRoute: '/login',
      // home: LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.USER_LIST) {
          return MaterialPageRoute(builder: (context) => UserListPage());
        }
        if (settings.name == AppRoutes.LOGIN) {
          return MaterialPageRoute(builder: (context) => LoginPage());
        }
        if (settings.name == AppRoutes.REGISTER) {
          return MaterialPageRoute(builder: (context) => RegisterPage());
        }
        if (settings.name == AppRoutes.PRODUCT_LIST) {
          return MaterialPageRoute(
              // builder: (context) => checkAuthenticate(ProductListPage()));
              builder: (context) => ProductListPage());
        }
        if (settings.name == AppRoutes.PRODUCT_FORM) {
          return MaterialPageRoute(builder: (context) => ProductForm());
        }
        // unknown route
        return MaterialPageRoute(builder: (_) => UnknownPage());
      },
      // routes: {
      //   AppRoutes.USER_LIST: (_) => UserListPage(),
      //   AppRoutes.HOME: (_) => LoginPage(),
      //   AppRoutes.PRODUCT_FORM: (_) => checkAuthenticate(ProductForm()),
      //   AppRoutes.LOGIN: (_) => LoginPage(),
      //   AppRoutes.PRODUCT_LIST: (_) => checkAuthenticate(ProductListPage()),
      //   AppRoutes.REGISTER: (_) => RegisterPage(),
      // },
    );
  }
}
