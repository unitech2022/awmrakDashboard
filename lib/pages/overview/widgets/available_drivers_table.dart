import 'package:dashbordawamrak/bloc/app_cubit/app_cubit.dart';
import 'package:dashbordawamrak/models/order.dart';
import 'package:dashbordawamrak/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../constants/style.dart';
import '../../orders_screen/orders_screen.dart';

/// Example without datasource
class AvailableDriversTable extends StatelessWidget {
  List<ResponseOrder> orders;

  AvailableDriversTable(this.orders);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: const [
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: "أخر 10 طلبات ",
              color: Colors.black,
              weight: FontWeight.bold,
              size: 25,
            ),
          ],
        ),
        const SizedBox(height: 30,),
        TableWidgetOrders(
          list: orders,
          name: "JDJDJD",
          image: "HDDDDDDD",
          id: "1",
          label: "الاقسام",
          onDelete: true,
          onUpdate: false,
        )
      ],
    );
  }
}
