import 'package:dashbordawamrak/models/cart_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/order_cubit/order_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/style.dart';

import '../../models/order.dart';

import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';

class DetailsOrderScreen extends StatefulWidget {
  final ResponseOrder orderModel;

  DetailsOrderScreen(this.orderModel);

  @override
  State<DetailsOrderScreen> createState() => _DetailsOrderScreenState();
}

class _DetailsOrderScreenState extends State<DetailsOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).detailsOrder(widget.orderModel.order!.id!);
  }

  @override
  Widget build(BuildContext context) {
    DateTime now =
        DateTime.parse(widget.orderModel.order!.createdAt.toString());
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    return Scaffold(
      body: BlocConsumer<OrderCubit, OrderState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: homeColor),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("تفاصيل الطلب",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "pnuB",
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  ContainerDetails(
                      'رقم الطلب : ', widget.orderModel.order!.id.toString()),
                  ContainerDetails(
                      'اسم العميل : ', widget.orderModel.userName),
                  ContainerDetails(
                      'رقم العميل : ', widget.orderModel.userPhone),

                  ContainerDetails(
                      'اسم المحل  : ', widget.orderModel.field!.name),
                  ContainerDetails(
                      'عنوان المحل  : ', widget.orderModel.field!.address),
                  ContainerDetails(
                      'رقم المحل : ', widget.orderModel.field!.phone),
                  ContainerDetails('السعر الاجمالي : ',
                      widget.orderModel.order!.price.toString()),
                  ContainerDetails('تاريخ الطلب : ', formattedDate),

                  const SizedBox(
                    height: 10,
                  ),
              SizedBox(
                height: 300,
                child: OrderCubit.get(context).loadDetails
                    ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                )
                    : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: OrderCubit.get(context)
                        .listOrderDetails
                        .length,
                    itemBuilder: (_, index) {
                      CartModel cart = OrderCubit.get(context)
                          .listOrderDetails[index];
                      return Container(
                        width: 200,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black, width: 1),
                            borderRadius:
                            BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Image.network(
                              baseUrlImages + cart.image!,
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Texts(
                              color: Colors.black,
                              title: cart.nameProduct,
                              fSize: 16,
                              weight: FontWeight.bold,
                            ),
                            DetailsProduct("السعر : ",
                                cart.price.toString(), Colors.red),
                            DetailsProduct(
                                "العدد المطلوب : ",
                                cart.quantity.toString(),
                                Colors.green),
                            DetailsProduct("الاجمالى  : ",
                                cart.total.toString(), Colors.blue)
                          ],
                        ),
                      );
                    }),
              )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsProduct extends StatelessWidget {
  final String title, value;
  final Color color;

  DetailsProduct(this.title, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Texts(
          color: Colors.black,
          title: title,
          fSize: 16,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          width: 10,
        ),
        Texts(
          color: color,
          title: value,
          fSize: 16,
        ),
      ],
    );
  }
}

class ContainerDetails extends StatelessWidget {
  final String? title, value;

  ContainerDetails(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: title,
            style: TextStyle(
                color: Colors.black.withOpacity(.5),
                fontFamily: "pnuB",
                fontSize: 15,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                  text: value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "pnuB",
                    color: Colors.green,
                    fontSize: 16,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
