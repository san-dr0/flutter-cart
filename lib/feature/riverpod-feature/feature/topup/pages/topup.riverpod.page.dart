import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:clean_arch2/feature/riverpod-feature/component/button/ink.dart';
import 'package:clean_arch2/feature/riverpod-feature/feature/riverpod/pod-entry/pod_entry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopUpRiverpodPage extends ConsumerStatefulWidget {
  const TopUpRiverpodPage({super.key});
  @override
  ConsumerState<TopUpRiverpodPage> createState () => _TopUpRiverpodPage();
}

class _TopUpRiverpodPage extends ConsumerState<TopUpRiverpodPage> {
  late TextEditingController _txtCreditBalance;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _txtCreditBalance = TextEditingController();
  }

  void onTopupBalance() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    var authPod = ref.read(authProvider);
    double balance = double.parse(_txtCreditBalance.text);

    ref.read(balancePod.notifier).updateBalance(
      email: authPod.value!.email,
      balance: balance
    );
    ref.read(balancePod.notifier).getCurrentBalance(email: authPod.value!.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(topUpTitle),
        backgroundColor: tealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Topup"),
              TextFormField(
                controller: _txtCreditBalance,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty amount";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("\$0.00")
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20.0,),
              inkButton(tapped: (param) {
                onTopupBalance();
              }, subTitle: "Credit balance")
            ],
          ),
        ),
      ),
    );
  }
}
