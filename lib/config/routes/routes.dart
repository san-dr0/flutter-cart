import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/feature/admin/feature/home/pages/admin.home.dart';
import 'package:clean_arch2/feature/admin/feature/users/pages/admin.user.list.page.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/login.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/signup.dart';
import 'package:clean_arch2/feature/cart/presentation/pages/cart.page.dart';
import 'package:clean_arch2/feature/dashboard/presentation/pages/dashboard.page.dart';
import 'package:clean_arch2/feature/home/presentation/pages/home.page.dart';
import 'package:clean_arch2/feature/transactions/presentation/pages/transaction.pages.dart';
import 'package:clean_arch2/feature/update-creds/pages/update-bloc.page.dart';
import 'package:clean_arch2/feature/view_certain_product/pages/view_certain_product.dart';
import 'package:go_router/go_router.dart';

GoRouter appRoutes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => HomePage(),),
  GoRoute(path: '/signup', builder: (context, state) => SignupPage(),),
  GoRoute(path: '/cart', builder: (context, state) => CartPage(),),
  GoRoute(path: '/view-certain-product', builder: (context, state) {
    ProductEntity productModel = state.extra as ProductEntity;

    return ViewCertainProductPage(productModel: productModel);
  },),
  GoRoute(path: '/login', builder: (context, state) => LoginPage(),),
  GoRoute(path: '/dashboard', builder: (context, state) => DashBoardPage(),),
  GoRoute(path: '/transactions', builder: (context, state) => TransactionPage(),),
  GoRoute(path: '/update-creds', builder: (context, state) => UpdateCredentialPage(),),
  GoRoute(
    path: '/admin', builder: (context, state) => AdminHomePage(),
    routes: adminRoutes
  ),
]);

// ADD pages here, it it belongs to admin
List<GoRoute> adminRoutes = [
  GoRoute(path: '/user-list', builder: (context, state) => AdminUserListPage(),)
];
