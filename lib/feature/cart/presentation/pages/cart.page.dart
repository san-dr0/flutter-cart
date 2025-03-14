import 'dart:developer';

import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:clean_arch2/feature/topup/presentation/bloc/topup.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/text.style.dart';
import '../../../auth/presentation/bloc/auth.event.dart';
import '../../../auth/presentation/bloc/auth.state.dart';
import '../../../topup/presentation/bloc/topup.event.dart';
import '../../../topup/presentation/bloc/topup.state.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  
  @override
  State<CartPage> createState () => _CartPage();
}

class _CartPage extends State<CartPage> {
  late CartBloc cartBloc;
  late AuthBloc authBloc;
  late TopUpBloc topUpBloc;

  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>();
    authBloc = context.read<AuthBloc>();
    topUpBloc = context.read<TopUpBloc>();

    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onCheckout(List<ProductEntity> cartProductList) {
    context.read<AuthBloc>().add(AuthOnCheckoutEvent(context: context, cartProductList: cartProductList));
  }

  void onDeductQuantity (ProductEntity productModel) {
    cartBloc.add(CartOnDeductQuanityEvent(productModel: productModel));
    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onAddQuantity (ProductEntity productModel) {
    cartBloc.add(CartOnAddQuantityEvent(productModel: productModel));
    cartBloc.add(CartOnAmountToPaidEvent());
  }

  void onRemoveProduct(ProductEntity productModel) {
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
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            BlocBuilder(
              bloc: context.watch<CartBloc>(),
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
            buildWhen: (previous, current) => current is CartProductState,
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
                log("currentState >>>> ");
                log(state.toString());
                if (state is AuthNotLoggedInState) {
                  ScaffoldMessenger.of(context)
                  .showSnackBar(
                    SnackBar(content: Text(authNotLoggedInTitle))
                  );
                }
                // else if (state is ) {
                //   showDialog(
                //     context: context, 
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text("Confirm"),
                //         content: Column(
                //           mainAxisSize: MainAxisSize.min,
                //           children: [
                //             Text("Are you sure you want to buy this item ?")
                //           ],
                //         ),
                //         actions: [
                //           InkWell(
                //             onTap: () {
                //               add(AuthCancelCartConfirmationDialog(context: context));
                //             },
                //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //             splashColor: Colors.teal,
                //             child: Ink(
                //               decoration: BoxDecoration(
                //                 color: Colors.teal[800],
                //                 borderRadius: BorderRadius.all(Radius.circular(10.0))
                //               ),
                //               child: Container(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   "Cancel",
                //                   style: textStyle(),
                //                 ),
                //               ),
                //             )
                //           ),
                //           BlocListener(
                //             bloc: this,
                //             listener: (context, state) {
                //               context.read<CartBloc>().add(CartOnResetProductListEvent(email: authState.email));
                //             },
                //             listenWhen: (previous, current) => current is AuthOnResetCartProductListState 
                //               || current is AuthOnValidCredentialsState,
                //             child: Text(""),
                //           ),
                //           InkWell(
                //             onTap: () {
                //               add(AuthProceedBuyCartItemConfirmationDialog(context: context, cartProductList: cartProductList));
                //             },
                //             borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //             splashColor: Colors.teal,
                //             child: Ink(
                //               decoration: BoxDecoration(
                //                 color: Colors.teal[800],
                //                 borderRadius: BorderRadius.all(Radius.circular(10.0))
                //               ),
                //               child: Container(
                //                 padding: const EdgeInsets.all(10.0),
                //                 child: Text(
                //                   "Yes of course",
                //                   style: textStyle(),
                //                 ),
                //               ),
                //             )
                //           )
                //         ],
                //       );
                //     },
                //     barrierDismissible: false
                //   );
                // }
                else if (state is AuthOnValidCredentialsState) {
                  topUpBloc.add(TopUpCheckCurrentActiveUserCurrentBalanceEvent());
                }
                
              },
              listenWhen: (previous, current) {
                return current is AuthNotLoggedInState || 
                  current is TopUpCurrentActiveUserBalanceIsInsufficientState || current is AuthOnValidCredentialsState;
              },
              child: Text(""),
            ),
            BlocListener(
              bloc: context.read<TopUpBloc>(),
              listener: (context, state) {
                if (state is TopUpCurrentActiveUserBalanceIsInsufficientState) {
                  log('should be here >>> TopUpCurrentActiveUserBalanceIsInsufficientState');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(cantProceedPurchaseInsufficientBalance))
                  );
                }
              },
              listenWhen: (previous, current) => current is TopUpCurrentActiveUserBalanceIsInsufficientState,
              child: const SizedBox(),
            )
          ],
        ),
      )
    );
  }
}
