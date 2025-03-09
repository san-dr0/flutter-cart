import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.state.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.bloc.dart';
import 'package:clean_arch2/feature/balance/presentation/bloc/balance.event.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.bloc.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.event.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopUpComponent extends StatefulWidget {
  const TopUpComponent({super.key});

  @override
  State<TopUpComponent> createState () => TopUpComponentRenderer();
}

class TopUpComponentRenderer extends State<TopUpComponent> {
  late TopUpBloc topUpBloc;
  late AuthBloc authBloc;
  late BalanceBloc balanceBloc;

  List<double> amountList = [100.00, 200.0, 300.0, 400.0, 500.0, 600.0, 700.0, 800.0, 900.0, 1000.0];
  List<Draggable> amountPositionList = [];
  double pos = 0.0;
  double topUpValue = 0.0;

  @override
  void initState() {
    super.initState();
    topUpBloc = context.read<TopUpBloc>();
    authBloc = context.read<AuthBloc>();
    balanceBloc = context.read<BalanceBloc>();

    for(int i =0 ; i < amountList.length; i++) {
      amountPositionList.add(
        Draggable(
          data: amountList[i],
          feedback: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.black
            ),
            width: 100,
            height: 100,
            child: Align(
              alignment: Alignment.center,
              child: Text(amountList[i].toString(), style: textStyle(fontSize: 20), textAlign: TextAlign.center),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.black
            ),
            width: 20,
            height: 20,
            child: Align(
              alignment: Alignment.center,
              child: Text(amountList[i].toString(), style: textStyle(fontSize: 20), textAlign: TextAlign.center),
            ),
          ),
        )
      );
      pos = pos + 60;
    }
  }

  void onTopUpNewCredit() {
    topUpBloc.add(TopUpOnTopUpNewBalanceEvent
      (
        topUpValue: topUpValue, 
        email: authBloc.state is AuthOnValidCredentialsState ? 
          (authBloc.state as AuthOnValidCredentialsState).authCredentialsModel!.email 
            : 
          ""
      )
    );
  }

  @override
  Widget build (BuildContext context) {
    
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: amountPositionList.length,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, 
                mainAxisSpacing: 3, 
                crossAxisSpacing: 3),
              itemBuilder: (context, index) {
                return amountPositionList[index];
              },
            ),
          ),

          DragTarget<double>(
            builder: (context, candidateData, rejectedData) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                width: MediaQuery.sizeOf(context).width,
                height: 100,
                decoration: BoxDecoration(
                  color: tealColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Creditted Balance: $topUpValue", 
                      style: textStyle(
                        color: Colors.white
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        onTopUpNewCredit();
                      },
                      splashColor: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.amber[800],
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Text(
                          "Top up",
                          style: textStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            onAcceptWithDetails: (DragTargetDetails<double> details) {
              setState(() {
                topUpValue += details.data;
              });
            },
          ),
          BlocListener(
            bloc: topUpBloc,
            listener: (context, state) {
              balanceBloc.add(BalanceOnChangedCurrentBalanceEvent(currentNewBalance: topUpValue));
            },
            listenWhen: (previous, current) => current is TopUpCurrentBalanceChangedState,
            child: SizedBox(),
          )
        ],
      ),
    ); 
  }
}
