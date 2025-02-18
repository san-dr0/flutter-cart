import 'package:clean_arch2/feature/auth/presentation/pages/signup.dart';
import 'package:clean_arch2/feature/home/presentation/pages/home.dart';
import 'package:go_router/go_router.dart';

GoRouter appRoutes = GoRouter(routes: [
  GoRoute(path: '/', builder: (context, state) => HomePage(),),
  GoRoute(path: '/signup', builder: (context, state) => SignupPage(),)
]);
