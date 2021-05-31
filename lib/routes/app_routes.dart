class AppRoutes {
  static const HOME = '/';
  static const PRODUCT_FORM = '/product/create/';
  static const PRODUCT_LIST = '/product/';
  static const USER_LIST = '/user/';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORBIDDEN = '/erro/403';
  static const UNKNOWN = '/erro/404';
  /*
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
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
  */
}
