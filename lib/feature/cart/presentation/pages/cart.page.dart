import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/text.style.dart';
import '../../../auth/presentation/bloc/auth.event.dart';
import '../../../auth/presentation/bloc/auth.state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  State<CartPage> createState () => _CartPage();
}

class _CartPage extends State<CartPage> {
  late CartBloc cartBloc;
  late AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>();
    authBloc = context.read<AuthBloc>();
    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onCheckout(List<ProductModel> cartProductList) {
    // cartBloc.add(CartOnCheckOutEvent(context: context));
    context.read<AuthBloc>().add(AuthOnCheckoutEvent(context: context, cartProductList: cartProductList));
  }

  void onDeductQuantity (ProductModel productModel) {
    cartBloc.add(CartOnDeductQuanityEvent(productModel: productModel));
    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onAddQuantity (ProductModel productModel) {
    cartBloc.add(CartOnAddQuantityEvent(productModel: productModel));
    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onRemoveProduct(ProductModel productModel) {
    cartBloc.add(CartOnRemoveProductEvent(productModel: productModel));
    cartBloc.add(CartOnAmountToPaidEvent());
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
            bloc: cartBloc,
            builder: (context, state) {
            if (state is CartProductState) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Name: ${state.productList[index].name}"),
                              Text("Price: ${state.productList[index].price}"),
                              Text("Quantity: ${state.productList[index].quantity}"),
                            ],
                          ),

                          Column(
                            children: [
                              Text(
                                "PHP: ${state.productList[index].price * state.productList[index].quantity}",
                                style: textStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 10.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      onAddQuantity(state.productList[index]);
                                    },
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
                                    onTap: () {
                                      onDeductQuantity(state.productList[index]);
                                    },
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
                                  ),
                                  const SizedBox(width: 8.0,),
                                  InkWell(
                                    onTap: () {
                                      onRemoveProduct(state.productList[index]);
                                    },
                                    splashColor: Colors.red[200],
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.red[400],
                                          size: 22.0,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
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
          },
          // buildWhen: (previous, current) => previous != current,
          ),
          Positioned(
            bottom: 1.00,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Card(
                elevation: 8.0,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: BlocBuilder(
                          bloc: cartBloc,
                          builder: (context, state) {
                            if (state is CartProductToPaidSatate) {
                              return Text(
                                "PHP ${state.totalToPaid.toString()}",
                                style: textStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                                ),
                              );
                            }
                    
                            return Text(
                              "0.00",
                              style: textStyle(
                                fontSize: 18.0
                              ),
                            );
                        },
                        buildWhen: (previous, current) => current is CartProductToPaidSatate,
                        ),
                      ),
                    ),
                    BlocBuilder(
                      bloc: cartBloc,
                      builder: (context, state) {
                        if (state is CartProductState) {
                          return InkWell(
                            onTap: () {
                              onCheckout(state.productList);
                            },
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            splashColor: Colors.teal,
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.teal[800],
                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  checkoutTitle,
                                  style: textStyle(
                                    fontSize: 20.0
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 10.0,)
                  ],
                ),
              )
            ),
          ),
          BlocListener(
            bloc: authBloc,
            listener: (context, state) {
              ScaffoldMessenger.of(context)
                .showSnackBar(
                  SnackBar(content: Text(authNotLoggedInTitle))
                );
            },
            listenWhen: (previous, current) {
              return current is AuthNotLoggedInState;
            },
            child: Text(""),
          )
        ],
      )
    );
  }
}
