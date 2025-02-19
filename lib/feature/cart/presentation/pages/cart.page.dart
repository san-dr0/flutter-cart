import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  State<CartPage> createState () => _CartPage();
}

class _CartPage extends State<CartPage> {

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(CartOnAmountToPaidEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cartTitle),
        backgroundColor: tealColor,
      ),
      body: Stack(
        children: [
          BlocBuilder(
            bloc: context.read<CartBloc>(),
            builder: (context, state) {
            if (state is CartProductState) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${state.productList[index].name}"),
                          Text("Price: ${state.productList[index].price}"),
                          Text("Quantity: ${state.productList[index].quantity}"),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {},
                                splashColor: Colors.teal[800],
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0,),
                              InkWell(
                                onTap: () {},
                                splashColor: Colors.teal[800],
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 22.0,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }, 
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 10.0,);
                },
                itemCount: state.productList.length
              );
            }
                  
            return Column(
              children: [
                Center(
                  child: Text(noCartRecordTitle),
                )
              ],
            );
          },),
          Positioned(
            bottom: 1.00,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Card(
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: BlocBuilder(
                      bloc: context.read<CartBloc>(),
                      builder: (context, state) {
                        if (state is CartProductToPaidSatate) {
                          return Text(
                            state.totalToPaid.toString(),
                            style: _textStyle(color: Colors.black, fontSize: 18.0),
                          );
                        }

                        return Text(
                          "0.00",
                          style: _textStyle(color: Colors.black, fontSize: 18.0),
                        );
                    },
                    buildWhen: (previous, current) => current is CartProductToPaidSatate,
                    ),
                  ),
                ),
              )
            ),
          )
        ],
      )
    );
  }
}

TextStyle _textStyle({
  double fontSize = 15.0, 
  FontWeight fontWeight = FontWeight.normal,
  Color color = Colors.white,
  }) {
  return TextStyle(
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}