import 'package:clean_arch2/config/db/hiver_riverpod/hiver_riverpod_model/hive_riverpod_model.dart';
import 'package:clean_arch2/config/db/hiver_riverpod/riverpod_db.dart';
import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/core/text.style.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/admin/model/admin.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/auth/model/signup/signup.model.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class ProductEntryPage extends ConsumerStatefulWidget {
  const ProductEntryPage({super.key});

  @override
  ConsumerState<ProductEntryPage> createState () => _ProductEntryPage();
}

class _ProductEntryPage extends ConsumerState<ProductEntryPage> {
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
    AdminCredentials? adminPod = ref.read(adminAuthPod).value;

    if (adminPod == null) {
      Fluttertoast.showToast(msg: authNotLoggedInTitle, toastLength: Toast.LENGTH_SHORT);
      return;
    }
    if (_formKey.currentState!.validate()) {
      String name = txtProductTitle.text;
      double price = double.parse( txtProductPrice.text);
      int quantity = int.parse(txtProductQty.text);
      
      final productEntryRiverPod = ProductEntryRiverPodModel(
        id: Uuid().v1(), // this is unused currently; we are using the auto_incremented of supaBase
        name: name, 
        price: price, 
        quantity: quantity
      );
      SupaLoginUser supaLoginUser = SupaLoginUser(email: adminPod!.email, password: adminPod.password);
      // ref.read(productProvider.notifier).insertProduct(productEntryRiverPod);
      // ref.read(productProvider.notifier).getAllProduct();

      ref.read(riverpodDbProvider.notifier).supaAdminInsertProduct(productEntryRiverPod, supaLoginUser);
      clearForm();
    }
  }

  void clearForm() {
    txtProductTitle.clear();
    txtProductPrice.clear();
    txtProductQty.clear();
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
              TextFormField(
                controller: txtProductTitle,
                decoration: InputDecoration(
                  label: Text("Name"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: txtProductPrice,
                decoration: InputDecoration(
                  label: Text("Price")
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty price";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: txtProductQty,
                decoration: InputDecoration(
                  label: Text("Quantity")
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty quantity";
                  }
                  return null;
                },
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
