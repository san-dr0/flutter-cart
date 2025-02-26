import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/transactions/presentation/bloc/transaction.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState () => _TransactionPage();
}

class _TransactionPage extends State<TransactionPage> {
  late TransactionBloc transactionBloc;

  @override
  void initState() {
    super.initState();
    transactionBloc = context.read<TransactionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(transactionTitle),
      ),
    );
  }
}
