import 'package:ecommerce_frontend/middlewares/auth_middleware.dart';
import 'package:ecommerce_frontend/routes/app_routes.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/user_store.dart';
import 'package:ecommerce_frontend/view/Login.dart';
import 'package:ecommerce_frontend/view/auth/Register.dart';
import 'package:ecommerce_frontend/view/errors/forbidden.dart';
import 'package:ecommerce_frontend/view/product/productList.dart';
import 'package:ecommerce_frontend/view/product/product_form.dart';
import 'package:ecommerce_frontend/view/errors/unknown.dart';
import 'package:ecommerce_frontend/view/user/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';

import 'model/User.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.LOGIN,
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.USER_LIST) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => AuthMidlleware.authBasic(UserListPage()));
        }
        if (settings.name == AppRoutes.LOGIN) {
          return MaterialPageRoute(
              settings: settings,
              builder: (_) => AuthMidlleware.guestBasic(LoginPage()));
        }
        if (settings.name == AppRoutes.REGISTER) {
          return MaterialPageRoute(
              builder: (_) => AuthMidlleware.guestBasic(RegisterPage()));
        }
        if (settings.name == AppRoutes.PRODUCT_LIST) {
          return MaterialPageRoute(
              builder: (_) => ProductListPage());
              // builder: (_) => AuthMidlleware.authBasic(ProductListPage()));
        }

        if (settings.name == AppRoutes.PRODUCT_FORM) {
          var product = settings.arguments;
          return MaterialPageRoute(builder: (context) => ProductForm(product));
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
