import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod/feature/riverpod/product/product_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class UpdateProductPage extends ConsumerStatefulWidget {
  ProductEntryRiverPodModel product;
  UpdateProductPage({super.key,required this.product});
  
  @override
  ConsumerState<UpdateProductPage> createState () => _UpdateProductPage();
}

class _UpdateProductPage extends ConsumerState<UpdateProductPage> {
  late TextEditingController txtProductName;
  late TextEditingController txtProductPrice;
  late TextEditingController txtProductQty;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    txtProductName = TextEditingController(text: widget.product.name);
    txtProductPrice = TextEditingController(text: widget.product.price.toString());
    txtProductQty = TextEditingController(text: widget.product.quantity.toString());
  }

  void onUpdateProduct () {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String productName = txtProductName.text;
    String productPrice = txtProductPrice.text;
    String productQty = txtProductQty.text;

    ProductEntryRiverPodModel productEntryRiverPodModel = ProductEntryRiverPodModel(
      id: widget.product.id, 
      name: productName,  
      price: double.parse(productPrice), 
      quantity: int.parse(productQty)
    );

    // ref.read(productPodProvider.notifier).updateSpecificProduct(productEntryRiverPodModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(updateProductTitle),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.sizeOf(context).width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: txtProductName,
                        validator: (value) {
                          if ( value == null || value.isEmpty) {
                            return "Product name is required";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: txtProductPrice,
                        validator: (value) {
                          if ( value == null || value.isEmpty) {
                            return "Product price is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        controller: txtProductQty,
                        validator: (value) {
                          if ( value == null || value.isEmpty) {
                            return "Product quantity is required";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 10.0,),
                      inkButton(tapped: (param) {
                        onUpdateProduct();
                      }, subTitle: "Update product", splashColor: Colors.teal[800]!, bgColor: tealColor)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
