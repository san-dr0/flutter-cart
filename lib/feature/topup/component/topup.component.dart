import 'package:clean_arch2/core/text.style.dart';
import 'package:flutter/material.dart';

class TopUpComponent extends StatefulWidget {
  @override
  State<TopUpComponent> createState () => TopUpComponentRenderer();
}

class TopUpComponentRenderer extends State<TopUpComponent> {
  List<int> amountList = [2, 3, 4, 5];
  List<Positioned> amountPositionList = [];
  double pos = 0.0;

  @override
  void initState() {
    super.initState();
    amountList.map((amount) {
      amountPositionList.add(
        Positioned(
          top: 0,
          left: pos,
          child: Draggable(
            feedback: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.black
              ),
              width: 50,
              height: 50,
              child: Text(amount.toString(), style: textStyle(fontSize: 30), textAlign: TextAlign.center),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.black
              ),
              width: 50,
              height: 50,
              child: Text(amount.toString(), style: textStyle(fontSize: 30), textAlign: TextAlign.center),
            ),
          ),
        )
      );
      pos += 50;
    });
    setState(() {
      
    });
  }
  @override
  Widget build (BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          ...amountPositionList
        ],
      ),
    ); 
  }
}
