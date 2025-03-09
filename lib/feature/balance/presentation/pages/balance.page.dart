import 'dart:developer';

import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.bloc.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.event.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceComponent extends StatefulWidget {
  const BalanceComponent({super.key});

  @override
  State<BalanceComponent> createState () => _BalanceComponent();
}

class _BalanceComponent extends State<BalanceComponent> {
  late BalanceBloc balanceBloc;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    balanceBloc = context.read<BalanceBloc>();
    authBloc = context.read<AuthBloc>();

    balanceBloc.add(BalanceOnGetCurrentBalanceEvent(
      email: (authBloc.state is AuthOnValidCredentialsState) ? (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.email : ""
    ));
  }

  @override
  Widget build (BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: balanceBloc,
          builder: (context, state) {
            if (state is BalanceOnLoadingState) {
              return Text("Checking balance.");
            }

            return Text(
              "Balance: ${balanceBloc.state is BalanceLoadedState ? (balanceBloc.state as BalanceLoadedState).currentBalance : "0.00"}",
              style: textStyle(),
            );
          },
          buildWhen: (previous, current) => previous != current,
        )
      ],
    );
  }
}
