import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
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

  void onNavigateToUpdateCreds() {
    dashBoardBloc.add(DashBoardOnNavigateToUpdateCredsEvent(context: context));
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
                      bloc: context.read<AuthBloc>(),
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
                    },
                  )
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
            ExpansionTile(title: Text("Settings"), children: [
              ListTile(
                onTap: () {
                  onNavigateToUpdateCreds();
                },
                title: Text("Update"),
              ),
              ListTile(
                onTap: () {},
                title: Text("Logout"),
              ),
            ],)
          ],
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: blocInformationList[index]['color'],
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blocInformationList[index]['title'],
                    style: textStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                  RichText(text: TextSpan(
                    text: blocInformationList[index]['description']
                  ))
                ],
              ),
            ),
          );
        }, 
        separatorBuilder: (context, index) {
          return SizedBox(height: 0.0);
        }, 
        itemCount: blocInformationList.length
      )
    );
  }
}
