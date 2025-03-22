import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';

class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState () => _ProductEntryPage();
}

class _ProductEntryPage extends State<ProductEntryPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController txtProductTitle;
  late TextEditingController txtProductPrice;
  late TextEditingController txtProductQty;

  @override
  void initState() {
    super.initState();
    txtProductTitle = TextEditingController();
    txtProductPrice = TextEditingController();
    txtProductQty = TextEditingController();
  }

  void addProductRecord () {
    String name = txtProductTitle.text;
    String price = txtProductPrice.text;
    String quantity = txtProductQty.text;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(adminPageProductEntryTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextField(
                controller: txtProductTitle,
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
              ),
              TextField(
                controller: txtProductPrice,
                decoration: InputDecoration(
                  label: Text("Price")
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtProductQty,
                decoration: InputDecoration(
                  label: Text("Quantity")
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10.0,),
              InkWell(
                onTap: () {
                  addProductRecord();
                },
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                splashColor: Colors.teal[800],
                child: Ink(
                  decoration: BoxDecoration(
                    color: tealColor,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "+ Create",
                      style: textStyle(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
