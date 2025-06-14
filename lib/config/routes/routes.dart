import 'dart:developer';

import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/feature-school/attendance/presentation/school.attendance.dart';
import 'package:clean_arch2/feature-school/auth/presentation/school.login.dart';
import 'package:clean_arch2/feature-school/registration/model/student.model.dart';
import 'package:clean_arch2/feature-school/registration/presentation/school.registration.dart';
import 'package:clean_arch2/feature-school/school-home/school.home.dart';
import 'package:clean_arch2/feature-school/teacher-dashboard/teacher.dashboard.dart';
import 'package:clean_arch2/feature/admin/feature/home/pages/admin.home.dart';
import 'package:clean_arch2/feature/admin/feature/users/pages/admin.user.list.page.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/login.dart';
import 'package:clean_arch2/feature/auth/presentation/pages/signup.dart';
import 'package:clean_arch2/feature/barcodepay/presentation/pages/barcode.page.dart';
import 'package:clean_arch2/feature/cart/presentation/pages/cart.page.dart';
import 'package:clean_arch2/feature/dashboard/presentation/pages/dashboard.page.dart';
import 'package:clean_arch2/feature/inquiries/presentation/page/inquiries.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/admin/pages/admin.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/pages/auth_riverpod_login.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/pages/auth_riverpod_signup.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/cart_list/pages/cart_list_page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/dashboard/page/dashboard.riverpod.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/product_list/pages/product_list.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/todo-home/pages/todo_home.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/transactions/pages/transaction_riverpod.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/update_product/pages/update_product.page.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/users/pages/user.page.dart';
import 'package:clean_arch2/feature/topup/presentation/pages/topup.page.dart';
import 'package:clean_arch2/feature/transactions/presentation/pages/transaction.pages.dart';
import 'package:clean_arch2/feature/update-creds/pages/update-bloc.page.dart';
import 'package:clean_arch2/feature/view_certain_product/pages/view_certain_product.dart';
import 'package:go_router/go_router.dart';

import '../../feature-school/update-student/update.student.dart';
import '../../feature/riverpod-feature/feature/product_entry/pages/presentation/product_entry.page.dart';
import '../../feature/riverpod-feature/feature/topup/pages/topup.riverpod.page.dart';
import '../../feature/riverpod-feature/feature/view_certain_product/presentation/view_certain_product.dart';

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
  // RIVERPOD
  GoRoute(path: '/', builder: (context, state) => TodoHomePage(),),
  GoRoute(path: '/admin-dashboard-v2', builder: (context, state) => AdminPageV2(),),
  GoRoute(path: '/admin-page-entry-v2', builder: (context, state) => ProductEntryPage(),),
  GoRoute(path: '/admin-page-list-v2', builder: (context, state) => ProductListPage(),),
  GoRoute(path: '/riverpod-on-view-cart-list', builder: (context, state) => CartListPodPage(),),
  GoRoute(path: '/riverpod-auth-login', builder: (context, state) => AuthRiverPodLoginPage(),),
  GoRoute(path: '/riverpod-auth-signup', builder: (context, state) => AuthRiverPodSignupPage(),),
  GoRoute(path: '/riverpod-dashboard', builder: (context, state) => DashBoardRiverpodPage(),),
  GoRoute(path: '/riverpod-topup', builder: (context, state) => TopUpRiverpodPage(),),
  GoRoute(path: '/riverpod-transactions', builder: (context, state) => TransactionHistoryRiverpodPage(),),
  GoRoute(path: '/riverpod-on-view-certain-product', builder: (context, state) {
    ProductEntryRiverPodModel product = state.extra as ProductEntryRiverPodModel;

    return ViewCertainProductPodPage(productEntryRiverPodModel: product);
  }),
  GoRoute(path: '/admin-update-product-v2', builder: (context, state) {
    ProductEntryRiverPodModel product = state.extra as ProductEntryRiverPodModel;

    return UpdateProductPage(product: product,);
  },),
  GoRoute(path: '/user-list-page', builder: (context, state) => UserListPage(),),
  // END OF RIVERPOD

  // SCHOOL FEATURE
  GoRoute(path: '/school-home', builder: (context, state) => SchoolHomePage(),),
  GoRoute(path: '/school-registration', builder: (context, state) => SchoolRegistration(),),
  GoRoute(path: '/school-login', builder: (context, state) => SchoolLoginPage(),),
  GoRoute(path: '/school-teacher-dashboard', builder: (context, state) => SchoolTeacherDashboardPage(),),
  GoRoute(path: '/school-teacher-update-student', builder: (context, state){
    var studentRecord = state.extra as StudentModel;
    
    return  SchoolUpdateStudent(studentModel: studentRecord);
  }),
  GoRoute(path: '/school-teacher-attendance', builder: (context, state) => SchoolAttendancePage(),)
]);

// ADD pages here, it it belongs to admin
List<GoRoute> adminRoutes = [
  GoRoute(path: '/user-list', builder: (context, state) => AdminUserListPage(),)
];
