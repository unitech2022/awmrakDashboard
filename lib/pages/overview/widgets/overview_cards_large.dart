import 'package:flutter/material.dart';

import '../../../models/home_model.dart';
import 'info_card.dart';



class OverviewCardsLargeScreen extends StatelessWidget {
  final ModelHome modelHome;
  OverviewCardsLargeScreen(this.modelHome);
  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Row(
              children: [
                InfoCard(
                  title: "عدد العملاء",
                  value: modelHome.countUsers.toString(),
                  onTap: () {},
                  topColor: Colors.orange.withOpacity(.9),
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد المتاجر",
                  value: modelHome.countMarkets.toString(),
                  topColor: Colors.lightGreen.withOpacity(.9),
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد المنتجات",
                  value: modelHome.countProduct.toString(),
                  topColor: Colors.redAccent.withOpacity(.9),
                  onTap: () {},
                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد الطلبات",
                  value: modelHome.countOrders.toString(),
                topColor: Colors.lightGreen.withOpacity(.5),
                  onTap: () {},
                ),
              ],
            );
  }
}