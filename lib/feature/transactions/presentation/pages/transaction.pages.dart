import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.bloc.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.event.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState () => _TransactionPage();
}

class _TransactionPage extends State<TransactionPage> {
  late TransactionBloc transactionBloc;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    transactionBloc = context.read<TransactionBloc>();
    authBloc = context.read<AuthBloc>();

    if (authBloc.state is AuthOnValidCredentialsState) {
      final currentActiveUser = (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel;

      transactionBloc.add(TransactionOnLoadedEvent(email: currentActiveUser!.email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(transactionTitle),
      ),
      body: BlocBuilder(
        bloc: transactionBloc,
        builder: (context, state) {
          if (state is TransactionOnLoadingState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  const SizedBox(height: 10.0,),
                  Text(pleaseWaitTitle)
                ],
              ),
            );
          }
          else if (state is TransactionOnLoadedRecordsState) {
            return ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(state.transactionRecords[index].dateTime.toString()),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 250.0,
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemBuilder: (context, cartItemIndex) {
                          return Card(
                            child: Column(
                              children: [
                                Text(
                                  state.transactionRecords[index].cartProduct[cartItemIndex].name
                                ),
                              ],
                            ),
                          );
                        }, 
                        separatorBuilder: (context, cartItemIndex) {
                          return SizedBox(height: 5.0,);
                        }, 
                        itemCount: state.transactionRecords[index].cartProduct.length
                      ),
                    )
                  ],
                );
              }, 
              separatorBuilder: (context, index) {
                return SizedBox(height: 5.0,);
              }, 
              itemCount: state.transactionRecords.length
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
