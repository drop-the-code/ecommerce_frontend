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
  static Widget checkAuthenticate(Widget fromPage) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    if (user != null) {
      if (user.token != null) return fromPage;
    }
    return ForbiddenPage();
  }

  static Widget GuestAuth(Widget fromPage) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    if (user != null) {
      return ProductListPage();
    }
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
      initialRoute: '/login',
      // home: LoginPage(),
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.USER_LIST) {
          return MaterialPageRoute(
              builder: (_) => checkAuthenticate(UserListPage()));
        }
        if (settings.name == AppRoutes.LOGIN) {
          return MaterialPageRoute(builder: (_) => GuestAuth(LoginPage()));
        }
        if (settings.name == AppRoutes.REGISTER) {
          return MaterialPageRoute(builder: (_) => GuestAuth(RegisterPage()));
        }
        if (settings.name == AppRoutes.PRODUCT_LIST) {
          return MaterialPageRoute(
              builder: (_) => checkAuthenticate(ProductListPage()));
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
