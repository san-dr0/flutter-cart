import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';

class TopUpComponent extends StatefulWidget {
  @override
  State<TopUpComponent> createState () => TopUpComponentRenderer();
}

class TopUpComponentRenderer extends State<TopUpComponent> {
  List<String> amountList = [];

  @override
  Widget build (BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Draggable(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Colors.black
                ),
                width: 50,
                height: 50,
                child: Text("2", style: textStyle(fontSize: 30), textAlign: TextAlign.center),
              ),
              feedback: Text("2"),
            )
          )
        ],
      ),
    ); 
  }
}
