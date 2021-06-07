import 'package:ecommerce_frontend/model/User.dart';
import 'package:ecommerce_frontend/shared/user_session.dart';
import 'package:ecommerce_frontend/shared/store/user_store.dart';
import 'package:ecommerce_frontend/view/errors/forbidden.dart';
import 'package:ecommerce_frontend/view/product/productList.dart';
import 'package:flutter/widgets.dart';

class AuthMidlleware {
  static Widget authBasic(Widget fromPage) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    if (user != null) {
      if (user.token != null) return fromPage;
    }
    return ForbiddenPage();
  }

  static Widget authOnlyEmployee(Widget fromPage) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    if (user != null) {
      if (user.token != null && user.role == "funcionario") return fromPage;
    }
    return ForbiddenPage();
  }

  static Widget guestBasic(Widget fromPage) {
    UserStore userStore = UserSession.instance;
    User user = userStore.getUser();
    if (user != null) {
      return ProductListPage();
    }
    return fromPage;
  }
}
