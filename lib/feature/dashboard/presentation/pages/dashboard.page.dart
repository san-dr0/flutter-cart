import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/domain/auth.domain.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/balance/presentation/pages/balance.page.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.bloc.dart';
import 'package:clean_arch2/feature/dashboard/presentation/bloc/dashboard.event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/bloc/auth.event.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState () => _DashBoardPage();
}

class _DashBoardPage extends State<DashBoardPage> {
  late AuthBloc authBloc;
  late CartBloc cartBloc;
  late DashBoardBloc dashBoardBloc;
  bool isBiometricEnabled = false;

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

  void onLogOutUser() {
    authBloc.add(AuthOnLogoutEvent(context: context));
  }

  void onNavigateToTopUp() {
    dashBoardBloc.add(DashBoardOnNavigateToTopUpEvent(context: context));
  }

  void onNavigateToBarcodePay () {
    dashBoardBloc.add(DashBoardOnNavigateToBarcodePayEvent(context: context));
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
      drawer: BlocBuilder(
        bloc: authBloc,
        builder: (context, state) {
          Color? headerColor = Colors.black;
          AuthCredentialsModel? authCredentialsModel;

          if (state is AuthOnValidCredentialsState) {
            headerColor = state.authCredentialsModel?.userType == 'User'? goldColor : tealColor;
            authCredentialsModel = state.authCredentialsModel;
          }

          return Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: headerColor
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Text("Name: ${authCredentialsModel?.lastName}, ${authCredentialsModel?.firstName}"),
                      ),
                      Positioned(
                        top: 20.0,
                        child: Text("Email: ${authCredentialsModel?.email}"),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: BalanceComponent(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0.0,
                        child: Text(
                          authCredentialsModel?.userType ?? '',
                          style: textStyle(
                            color: Colors.white
                          ),
                        ),
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
                if (authCredentialsModel?.userType == 'User')
                  ListTile(
                    onTap: () {
                      onNavigateToTransaction();
                    },
                    title: Text("My Transactions"),
                  ),
                if (authCredentialsModel?.userType == 'User')
                  ListTile(
                    onTap: () {
                      onNavigateToTopUp();
                    },
                    title: Text("Top Up"),
                  ),
                if (authCredentialsModel?.userType == 'User')
                  ListTile(
                    onTap: () {
                      onNavigateToBarcodePay();
                    },
                    title: Text("Barcode Pay"),
                  ),
                if (authCredentialsModel?.userType == 'Admin')
                  ListTile(
                    onTap: () {},
                    title: Text("View Users"),
                  ),
                if (authCredentialsModel?.userType == 'Admin')
                  ListTile(
                    onTap: () {},
                    title: Text("View Transactions"),
                  ),
                if (authCredentialsModel?.userType == 'Admin')
                  ListTile(
                    onTap: () {},
                    title: Text("View Graphs"),
                  ),
                ExpansionTile(
                  title: Text("Settings"), 
                  children: [
                    ListTile(
                      onTap: () {
                        onNavigateToUpdateCreds();
                      },
                      title: Text("Update"),
                    ),
                    ListTile(
                      onTap: () {
                        setState(() {
                          isBiometricEnabled = !isBiometricEnabled;
                        });
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Enable biometrics"),
                          Switch(
                            value: isBiometricEnabled, 
                            onChanged: (bool? value) {
                              
                            })
                        ],
                      )
                    ),
                    ListTile(
                      onTap: () {
                        onLogOutUser();
                      },
                      title: Text("Logout"),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            myLearningThroughThisJourneyTitle,
            style: textStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10.0,),
          Expanded(
            child: ListView.separated(
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
            ),
          ),
        ],
      )
    );
  }
}
