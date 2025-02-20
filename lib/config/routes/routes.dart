import 'package:clean_arch2/feature/auth/presentation/pages/login.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/signup.dart';
import 'package:clean_arch2/feature/cart/presentation/pages/cart.page.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:clean_arch2/feature/home/presentation/pages/home.page.dart';
import 'package:clean_arch2/feature/view_certain_product/pages/view_certain_product.dart';
import 'package:go_router/go_router.dart';

GoRouter appRoutes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => HomePage(),),
  GoRoute(path: '/signup', builder: (context, state) => SignupPage(),),
  GoRoute(path: '/cart', builder: (context, state) => CartPage(),),
  GoRoute(path: '/view-certain-product', builder: (context, state) {
    ProductModel productModel = state.extra as ProductModel;

    return ViewCertainProductPage(productModel: productModel);
  },),
  GoRoute(path: '/login', builder: (context, state) => LoginPage(),),
]);
