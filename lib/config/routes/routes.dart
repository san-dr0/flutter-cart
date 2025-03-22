import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/feature/admin/feature/home/pages/admin.home.dart';
import 'package:clean_arch2/feature/admin/feature/users/pages/admin.user.list.page.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/login.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/signup.dart';
import 'package:clean_arch2/feature/barcodepay/presentation/pages/barcode.page.dart';
import 'package:clean_arch2/feature/cart/presentation/pages/cart.page.dart';
import 'package:clean_arch2/feature/dashboard/presentation/pages/dashboard.page.dart';
import 'package:clean_arch2/feature/home/presentation/pages/home.page.dart';
import 'package:clean_arch2/feature/inquiries/presentation/page/inquiries.page.dart';
import 'package:clean_arch2/feature/riverpod/feature/admin/pages/admin.page.dart';
import 'package:clean_arch2/feature/riverpod/feature/product_list/pages/product_list.page.dart';
import 'package:clean_arch2/feature/riverpod/feature/todo-home/pages/todo_home.page.dart';
import 'package:clean_arch2/feature/topup/presentation/pages/topup.page.dart';
import 'package:clean_arch2/feature/transactions/presentation/pages/transaction.pages.dart';
import 'package:clean_arch2/feature/update-creds/pages/update-bloc.page.dart';
import 'package:clean_arch2/feature/view_certain_product/pages/view_certain_product.dart';
import 'package:go_router/go_router.dart';

import '../../feature/riverpod/feature/product_entry/pages/presentation/product_entry.page.dart';

GoRouter appRoutes = GoRouter(routes: [
  // GoRoute(path: '/', builder: (context, state) => HomePage(),),
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
  GoRoute(path: '/top-up', builder: (context, state) => TopUpPage(),),
  GoRoute(path: '/barcode-pay', builder: (context, state) => BarcodePayPage(),),
  GoRoute(
    path: '/admin', builder: (context, state) => AdminHomePage(),
    routes: adminRoutes
  ),
  GoRoute(path: '/inquiry', builder: (context, state) => InquiryPage(),),
  GoRoute(path: '/', builder: (context, state) => TodoHomePage(),),
  GoRoute(path: '/admin-dashboard-v2', builder: (context, state) => AdminPageV2(),),
  GoRoute(path: '/admin-page-entry-v2', builder: (context, state) => ProductEntryPage(),),
  GoRoute(path: '/admin-page-list-v2', builder: (context, state) => ProductListPage(),),
]);

// ADD pages here, it it belongs to admin
List<GoRoute> adminRoutes = [
  GoRoute(path: '/user-list', builder: (context, state) => AdminUserListPage(),)
];
