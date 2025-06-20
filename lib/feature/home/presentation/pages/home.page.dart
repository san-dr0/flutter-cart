import 'package:clean_arch2/config/db/hive_model/product_model/product_model.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.bloc.dart';
import 'package:clean_arch2/feature/auth/presentation/bloc/auth.event.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.state.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.bloc.dart';
import 'package:clean_arch2/feature/home/presentation/bloc/home.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/color.dart';
import '../../../cart/presentation/bloc/cart.event.dart';
import '../bloc/home.event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState () => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<ProductEntity> productList = [];
  late CartBloc cartBloc;
  
  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>();
    context.read<HomeProductBloc>().add(HomeOnLoadedEvent());
  }

  void onBuyProduct(ProductEntity productModel) {
    context.read<CartBloc>().add(CartOnBuyProductEvent(productModel: productModel));
  }

  void onGoToCart() {
    context.read<CartBloc>().add(CartOnViewProductListEvent(context: context));
  }

  void onViewProduct(ProductEntity productModel) {
    context.read<HomeProductBloc>().add(HomeOnViewCertainProductEvent(
      context: context, 
      productModel: productModel
    ));
  }

  void onLoginUser() {
    context.read<AuthBloc>().add(AuthOnAlreadyHaveAnAccountEvent(context: context));
  }

  void onGoToSchoolFeature() {
    context.push('/school-home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(homeTitle),
        backgroundColor: tealColor,
        actions: [
          IconButton(
            onPressed: () {
              onLoginUser();
            }, 
            icon: Icon(
              Icons.person,
              color: Colors.white,
            )
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {
                  onGoToCart();
                }, 
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.red[300]
                )
              ),
              Positioned(
                top: 0,
                right: 10,
                child: BlocBuilder(
                  bloc: cartBloc,
                  builder: (context, state) {
                    if (state is CartProductState) {
                      return Text(state.productList.length.toString());
                    }
                    return const Text("0");
                  },
                  // buildWhen: (previous, current) => previous != current
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(productListTitle, style: _textStyle
              (
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
            const SizedBox(height: 10.0,),
            Expanded(
              child: 
              BlocBuilder(
                bloc: context.read<HomeProductBloc>(),
                builder: (context, state) {
                  if (state is HomeProductOnLoadedState) {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name: ${state.productList[index].name}", style: _textStyle(color: Colors.black),),
                                Text("Price: ${state.productList[index].price}", style: _textStyle(color: Colors.black),),
                                Text("Qty: ${state.productList[index].quantity}", style: _textStyle(color: Colors.black),),
                                
                                const SizedBox(height: 10.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        onBuyProduct(state.productList[index]);
                                      },
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      splashColor: Colors.teal[800],
                                      child: SizedBox(
                                        width: 100.0,
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "Buy",
                                              textAlign: TextAlign.center,
                                              style: _textStyle(
                                                fontSize: 18.0
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0,),
                                    InkWell(
                                      onTap: () {
                                        onViewProduct(state.productList[index]);
                                      },
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      splashColor: Colors.teal[800],
                                      child: SizedBox(
                                        width: 100.0,
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            color: Colors.teal,
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              "View",
                                              textAlign: TextAlign.center,
                                              style: _textStyle(
                                                fontSize: 18.0
                                              ),
                                            ),
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
                  return const Text("No record");
                },
              ),
            ),
            BlocListener(
              bloc: cartBloc,
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(emptyCartTitle))
                );
              },
              listenWhen: (previous, current) {
                return current is CartProductEmptyState;
              },
              child: Text(""),
            )
          ],
        ),
      ),
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