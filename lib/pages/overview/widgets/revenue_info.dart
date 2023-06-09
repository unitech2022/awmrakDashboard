import 'package:flutter/material.dart';


import '../../../constants/style.dart';

class RevenueInfo extends StatelessWidget {
  final String title;
  final String amount;

  const RevenueInfo({ required this.title, required this.amount}) ;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$title \n\n",
                style: TextStyle(color: lightGrey, fontSize: 16)),
            TextSpan(
                text: "\$ $amount",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ])),
    );
  }
}
