import 'package:dashbordawamrak/bloc/app_cubit/app_cubit.dart';
import 'package:dashbordawamrak/models/home_model.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'info_card.dart';


class OverviewCardsMediumScreen extends StatelessWidget {
final ModelHome modelHome;

const OverviewCardsMediumScreen(this.modelHome, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
                  children: [
                    InfoCard(
                      title: "عدد العملاء",
                      value: modelHome.countUsers.toString(),
                      onTap: () {

                        // Get.to(AddProducts());
                      },
                  topColor: Colors.orange,

                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد المتاجر",
                      value: modelHome.countMarkets.toString(),
                  topColor: Colors.lightGreen,

                      onTap: () {},
                    ),
                  
                  ],
                ),
            SizedBox(
                      height: _width / 64,
                    ),
                  Row(
                  children: [
             
                    InfoCard(
                      title: "عدد المنتجات",
                      value: modelHome.countProduct.toString(),
                  topColor: Colors.redAccent,

                      onTap: () {},
                    ),
                    SizedBox(
                      width: _width / 64,
                    ),
                    InfoCard(
                      title: "عدد الطلبات",
                      value: modelHome.countOrders.toString(),
                      onTap: () {}, topColor: Colors.transparent,
                    ),
                
                  ],
                ),
      ],
    );
  }
}