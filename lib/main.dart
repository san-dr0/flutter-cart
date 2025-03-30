import 'dart:developer';

import 'package:clean_arch2/config/db/app_db.dart';
import 'package:clean_arch2/config/db/hive_model/auth_model/auth_model.dart';
import 'package:clean_arch2/config/db/hive_model/mock_auth/mock_auth.model.dart';
import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/config/db/hive_model/topup_model/balance_model.dart';
import 'package:clean_arch2/config/db/hive_model/transaction_model/transaction_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/auth_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/balance_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/routes/routes.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.bloc.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.bloc.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/auth.signup.riverpod.model.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.bloc.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.bloc.dart';
import 'package:clean_arch2/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
// flutter pub run build_runner build
// flutter pub run build_runner watch
// https://medium.com/gytworkz/hive-database-in-flutter-store-and-retrieve-data-locally-d53b333d74ee // BLOG ABOUT HIVE
// https://platform.openai.com/docs/api-reference/authentication
// VERTEX Dodcs
// https://firebase.google.com/docs/vertex-ai/get-started?platform=flutter
// https://docs.flutter.dev/ai-toolkit
// https://www.datacamp.com/tutorial/vertex-ai-tutorial?utm_source=google&utm_medium=paid_search&utm_campaignid=19589720824&utm_adgroupid=157098106775&utm_device=c&utm_keyword=&utm_matchtype=&utm_network=g&utm_adpostion=&utm_creative=733936254857&utm_targetid=dsa-2264919291989&utm_loc_interest_ms=&utm_loc_physical_ms=1011159&utm_content=&accountid=9624585688&utm_campaign=230119_1-sea~dsa~tofu_2-b2c_3-apac_4-prc_5-na_6-na_7-le_8-pdsh-go_9-nb-e_10-na_11-na&gad_source=1&gclid=Cj0KCQjws-S-BhD2ARIsALssG0a8YZUWDcm764t8t3_YWCeJESpHjw6L1J5aubr_ENgZpb4CdEhGWGYaAtySEALw_wcB

/* River pod things
  1) dart run build_runner watch
  1.1) this generate a Notifier
*/
final Di = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  Hive.registerAdapter(ProductEntityAdapter());
  Hive.registerAdapter(TransactionEntityAdapter());
  Hive.registerAdapter(UserInfoModelAdapter());
  Hive.registerAdapter(AuthEntityAdapter());
  Hive.registerAdapter(BalanceEntityAdapter());

  // Riverpod adapter
  Hive.registerAdapter(ProductEntryRiverPodModelAdapter());
  Hive.registerAdapter(AuthRiverpodModelAdapter());
  Hive.registerAdapter(AuthSignupRiverpodModelAdapter());
  Hive.registerAdapter(BalanceRiverpodModelAdapter());
  
  Di.registerLazySingleton(() => AppDatabase());
  Di.registerLazySingleton(() => CartBloc(appDatabase: Di()));
  Di.registerLazySingleton(() => AuthBloc(appDatabase: Di()));
  Di.registerLazySingleton(() => TransactionBloc(appDatabase: Di()));
  // final appDoc = await path_provider.getApplicationCacheDirectory();
  await Hive.initFlutter();
  
  AppDatabase appDB = AppDatabase();
  appDB.initBaseRecords();

  /* Bloc */
  // runApp(
  //   MultiBlocProvider(
  //     providers: [
  //       BlocProvider(create: (context) => HomeProductBloc(appDatabase: appDB),),
  //       BlocProvider(create: (context) => CartBloc(appDatabase: Di())),
  //       BlocProvider(create: (context) => AuthBloc(appDatabase: Di())),
  //       BlocProvider(create: (context) => DashBoardBloc()),
  //       BlocProvider(create: (context) => TransactionBloc(appDatabase: Di())),
  //       BlocProvider(create: (context) => TopUpBloc(appDatabase: Di())),
  //       BlocProvider(create: (context) => BalanceBloc(appDatabase: Di())),
  //     ], 
  //     child: const MyApp()
  //   )
  // );

  /* for Riverpod */
  runApp(
    ProviderScope(child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
