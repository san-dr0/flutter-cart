import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.bloc.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState () => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage> {
  late AuthBloc authBloc;
  late CartBloc cartBloc;
  late DashBoardBloc dashBoardBloc;

  @override
  void initState() {
    super.initState();
    authBloc = context.read<AuthBloc>();
    cartBloc = context.read<CartBloc>();
    dashBoardBloc = context.read<DashBoardBloc>();
  }

  void onNavigateToShop() {
    dashBoardBloc.add(DashBoardOnNavigateToShopEvent(context: context));
  }

  void onNavigateToTransaction() {
    dashBoardBloc.add(DashBoardOnNavigateToTransactionsEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dashBoardTitle),
        backgroundColor: tealColor,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return IconButton(onPressed: () {
            Scaffold.of(context).openDrawer();
          }, icon: Icon(Icons.menu));
        },),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: tealColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder(
                    bloc: authBloc,
                    builder: (context, state) {
                    if (state is AuthOnValidCredentialsState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${state.authCredentialsModel!.lastName}, ${state.authCredentialsModel!.firstName}"),
                          Text("Email: ${state.authCredentialsModel!.email}"),
                        ],
                      );
                    }
                    return Text("No user");
                  },)
                ],
              ),
            ),
            ListTile(
              onTap: () {
                onNavigateToShop();
              },
              title: Text("Shop"),
            ),
            ListTile(
              onTap: () {
                onNavigateToTransaction();
              },
              title: Text("Transactions"),
            ),
            ListTile(
              onTap: () {},
              title: Text("Settings"),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            child: Column(
              children: []
            )
          ), // This card is for 3 types of information EVENT, BLOC, STATE
          Card(
            child: Column(
              children: []
            )
          ),
          Card(
            child: Column(
              children: []
            )
          )
        ],
      ),
    );
  }
}
