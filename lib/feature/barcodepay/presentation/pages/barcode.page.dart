import 'package:clean_arch2/core/color.dart';
import 'package:clean_arch2/core/string.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BarcodePayPage extends StatefulWidget {
  const BarcodePayPage({super.key});

  @override
  State<BarcodePayPage> createState () => _BarcodePayPage();
}

class _BarcodePayPage extends  State<BarcodePayPage> {

  @override
  void initState() {
    super.initState();
  }

  void onGenerateQR () {
    
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: tealColor,
        title: Text(barcodePayTitle),
      ),
      body: Column(
        children: [
          QrImageView(
            data: 'wew',
            version: QrVersions.auto,
            size: 100.0,
          ),
          ElevatedButton(onPressed: (){}, child: Text("Generate QR"))
        ],
      ),
    );
  }
}
