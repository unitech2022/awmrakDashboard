import 'package:flutter/material.dart';
import '../../../models/home_model.dart';
import 'info_card_small.dart';


class OverviewCardsSmallScreen extends StatelessWidget {
  final ModelHome modelHome;

  OverviewCardsSmallScreen(this.modelHome);
  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "عدد العملاء",
            value: modelHome.countUsers.toString(),
                        onTap: () {},
                        isActive: true,
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "عدد المتاجر",
                        value: modelHome.countMarkets.toString(),
                        onTap: () {},
                      ),
                     SizedBox(
                        height: _width / 64,
                      ),
                          InfoCardSmall(
                            title: "عدد المنتجات",
                            value: modelHome.countProduct.toString(),
                        onTap: () {},
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "عدد الطلبات",
                        value: modelHome.countOrders.toString(),
                        onTap: () {},
                      ),
                  
        ],
      ),
    );
  }
}