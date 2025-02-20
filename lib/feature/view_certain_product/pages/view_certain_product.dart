import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/cart/presentation/bloc/cart.bloc.dart';
import 'package:clean_arch2/feature/home/domain/product.domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../cart/presentation/bloc/cart.event.dart';

// ignore: must_be_immutable
class ViewCertainProductPage extends StatefulWidget {
  ViewCertainProductPage({super.key, required this.productModel});
  
  ProductModel productModel;

  @override
  State<ViewCertainProductPage> createState () => _ViewCertainProductPage();
}

class _ViewCertainProductPage extends State<ViewCertainProductPage> {
  late CartBloc cartBloc;
  
  @override
  void initState() {
    super.initState();
    cartBloc = context.read<CartBloc>();
  }
  void onAddToCart(ProductModel productModel) {
    cartBloc.add(CartOnBuyProductEvent(productModel: productModel));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          viewCertainProductTitle,
        ),
        backgroundColor: tealColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      "Name: ${widget.productModel.name}",
                      style: textStyle(
                        color: Colors.black,
                        fontSize: 22.0
                      ),
                    ),
                    Text(
                      "PHP ${widget.productModel.price.toString()}",
                      style: textStyle(
                        color: Colors.black,
                        fontSize: 18.0
                      ),
                    ),
                    Text(
                      "Qty: ${widget.productModel.quantity.toString()}",
                      style: textStyle(
                        color: Colors.black,
                        fontSize: 22.0
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    InkWell(
                      onTap: () {
                        onAddToCart(widget.productModel);
                      },
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      splashColor: Colors.teal[800],
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Add to cart",
                            style: textStyle(
                              color: Colors.white,
                              fontSize: 18.0
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
