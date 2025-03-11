import 'dart:developer';

import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.bloc.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.event.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  void onPayWithQR({String qrCodeInfo = ""}) {
    transactionBloc.add(TransactionOnPayWithQREvent(qrCodeInfo: qrCodeInfo));
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
                double eachTotal = state.transactionRecords[index].cartProduct.fold(0.0, (p, a) => p+(a.price * a.quantity));
                String dateTime = state.transactionRecords[index].dateTime.toString();
                String buyerEmail = state.transactionRecords[index].email;
                bool isPaid = state.transactionRecords[index].isPaid;
                log("isPaid: ${state.transactionRecords[index].isPaid}");

                String qrCodeInfo = 'amountToPay&${eachTotal.toStringAsFixed(2)};email&$buyerEmail;dateTime&$dateTime;isPaid&$isPaid';
                if (eachTotal <= 0) {
                  return SizedBox();
                }

                return Column(
                  children: [
                    Text(
                      DateFormat('MMMM dd, yyyy').format(state.transactionRecords[index].dateTime),
                      style: textStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      height: 250.0,
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        shrinkWrap: false,
                        itemBuilder: (context, cartItemIndex) {
                          String itemAmountToPay = (
                            state.transactionRecords[index].cartProduct[cartItemIndex].quantity * state.transactionRecords[index].cartProduct[cartItemIndex].price
                          ).toStringAsFixed(2);

                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name: ${state.transactionRecords[index].cartProduct[cartItemIndex].name}",
                                        style: textStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0
                                        ),
                                      ),
                                      Text(
                                        "Price: ${state.transactionRecords[index].cartProduct[cartItemIndex].price}"
                                      ),
                                      Text(
                                        "Qty: ${state.transactionRecords[index].cartProduct[cartItemIndex].quantity}"
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Price: $itemAmountToPay",
                                    style: textStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }, 
                        separatorBuilder: (context, cartItemIndex) {
                          return SizedBox(height: 5.0,);
                        }, 
                        itemCount: state.transactionRecords[index].cartProduct.length
                      ),
                    ),
                    Stack(
                      children: [
                        Column(
                          children: [
                            QrImageView(
                              data: qrCodeInfo,
                              version: QrVersions.auto,
                              size: 100.0,
                            ),
                            if (!isPaid)
                              InkWell(
                                onTap: () {
                                  onPayWithQR(qrCodeInfo: qrCodeInfo);
                                },
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                splashColor: Colors.teal,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    color: Colors.teal[800]
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      payWithQRTitle,
                                      style: textStyle(),
                                    ),
                                  ),
                                ),
                              ),
                            Text(
                              "$totalTitle ${eachTotal.toStringAsFixed(2)}",
                              style: textStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: !isPaid? 50 : 30,
                          child: RotationTransition(
                            turns: AlwaysStoppedAnimation(15/360),
                            child: Text(
                              !isPaid ? unpaidTitle : paidTitle,
                              style: textStyle(
                                fontSize: 32,
                                color: !isPaid ? Colors.deepOrange[600]! : tealColor
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                );
              }, 
              separatorBuilder: (context, index) {
                return SizedBox(height: 5.0,);
              }, 
              itemCount: state.transactionRecords.length-1
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
