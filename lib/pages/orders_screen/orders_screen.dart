import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashbordawamrak/models/order.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../bloc/order_cubit/order_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';

import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';
import '../details_order_screen/details_order_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen();

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OrderCubit.get(context).getOrders(endPoint: "order/get-Orders-admin");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderCubit, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              Obx(
                () => Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            top: ResponsiveWidget.isSmallScreen(context)
                                ? 56
                                : 6),
                        child: CustomText(
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                          color: homeColor,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: OrderCubit.get(context).loadOrders
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 5,
                            color: Colors.blue,
                          ),
                        )
                      : TableWidgetOrders(
                          list: OrderCubit.get(context).listOrders,
                          name: "JDJDJD",
                          image: "HDDDDDDD",
                          id: "1",
                          label: "الاقسام",
                          onDelete: false,
                          onUpdate: false,
                        )),
            ],
          ),
        );
      },
    );
  }
}

class TableWidgetOrders extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<ResponseOrder> list;

  TableWidgetOrders(
      {required this.label,
      required this.name,
      required this.id,
      required this.onDelete,
      required this.onUpdate,
      required this.image,
      required this.list});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   children: [
            //     SizedBox(
            //       width: 10,
            //     ),
            //     CustomText(
            //       text: label,
            //       color: lightGrey,
            //       weight: FontWeight.bold,
            //     ),
            //   ],
            // ),
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 600,
                columns: const [
                  DataColumn2(
                    label: Text("رقم"),
                    size: ColumnSize.S,
                  ),
                  DataColumn2(
                    size: ColumnSize.M,
                    label: Text('اسم المحل '),
                  ),
                  DataColumn(
                    label: Text("الصورة"),
                  ),
                  DataColumn2(
                    size: ColumnSize.S,
                    label: Text('تاريخ الطلب'),
                  ),
                  DataColumn(
                    label: Text('تفاصيل '),
                  ),
                  DataColumn(
                    label: Text('ارسال'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(list.length, (index) {
                  DateTime now =
                      DateTime.parse(list[index].order!.createdAt.toString());
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);
                  return DataRow2(specificRowHeight: 100, cells: [
                    DataCell(CustomText(
                      text: "${list[index].order!.id}",
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),
                    DataCell(CustomText(
                      text:list[index].field==null?"غير موجود": "${list[index].field!.name}",
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),
                    DataCell(SizedBox(
                      width: 80,
                      height: 80,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: CachedNetworkImage(
                          imageUrl:list[index].field==null?"notfound" :"$baseUrlImages${list[index].field!.image}",
                          height: 60,
                          width: 100,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    )),
                    DataCell(CustomText(
                      text: formattedDate,
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    )),

                    DataCell(Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 120,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color:Colors.green,
                        onPressed: () {

                          Get.to(DetailsOrderScreen(list[index]));

/*                          showDialog(
                            context: context,
                            builder: (context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Texts(
                                    fSize: 18,
                                    color: Colors.red,
                                    title: list[index].order!.id.toString(),
                                    weight: FontWeight.bold),
                                content: Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: list[index].order!.status == 0
                                        ? "ارسال الطلب الى المحل "
                                        : "وقف الطلب",
                                    weight: FontWeight.bold),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  MaterialButton(
                                    minWidth: 50,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text("نعم",
                                          style: TextStyle(
                                              fontFamily: "pnuM",
                                              color: Colors.white)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 1);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "الغاء",
                                      style: TextStyle(fontFamily: "pnuM"),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 0);
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            print(value);
                            if (value == null) {
                              return;
                            } else if (value == 1) {
                              if (list[index].order!.status == 0) {
                                OrderCubit.get(context).updateStatusOrder(context: context,
                                  fcmToken: list[index].field!.token,
                                    status: 1, id: list[index].order!.id);
                              } else {
                                OrderCubit.get(context).updateStatusOrder(context: context,
                                    fcmToken: list[index].field!.token,
                                    status: 0, id: list[index].order!.id);
                              }
                            }
                          });*/
                        },
                        child: const Center(
                          child: CustomText(
                            text: "التفاصيل",
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 16,
                          ),
                        ),
                      ),
                    )),

                    DataCell(Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 120,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color:list[index].order!.status == 1?Colors.green: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: Texts(
                                    fSize: 18,
                                    color: Colors.red,
                                    title: list[index].order!.id.toString(),
                                    weight: FontWeight.bold),
                                content: Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: list[index].order!.status == 0
                                        ? "ارسال الطلب الى المحل "
                                        : "وقف الطلب",
                                    weight: FontWeight.bold),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  MaterialButton(
                                    minWidth: 50,
                                    color: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      child: Text("نعم",
                                          style: TextStyle(
                                              fontFamily: "pnuM",
                                              color: Colors.white)),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 1);
                                    },
                                  ),
                                  TextButton(
                                    child: const Text(
                                      "الغاء",
                                      style: TextStyle(fontFamily: "pnuM"),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context, 0);
                                    },
                                  ),
                                ],
                              );
                            },
                          ).then((value) {
                            print(value);
                            if (value == null) {
                              return;
                            } else if (value == 1) {
                              if (list[index].order!.status! > 0 ) {
                                OrderCubit.get(context).updateStatusOrder(
                                    fcmToken: list[index].field!.token,
                                    context: context,
                                    userId: list[index].field!.userId,
                                    status: 0, id: list[index].order!.id);
                              } else {
                                OrderCubit.get(context).updateStatusOrder(
                                    fcmToken: list[index].field!.token,
                                    userId: list[index].field!.userId,
                                    context: context,
                                    status: 1, id: list[index].order!.id);
                              }
                            }
                          });
                        },
                        child: Center(
                          child: CustomText(
                            text: list[index].order!.status == 0
                                ? "ارسال"
                                : "تم الارسال",
                            color: Colors.white,
                            weight: FontWeight.bold,
                            size: 16,
                          ),
                        ),
                      ),
                    )),
                    DataCell(Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.red,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              // return object of type Dialog
                              return Container(
                                // height: 200,
                                child: AlertDialog(
                                  title: Texts(
                                      fSize: 18,
                                      color: Colors.red,
                                      title: list[index].order!.id.toString(),
                                      weight: FontWeight.bold),
                                  content: Texts(
                                      fSize: 20,
                                      color: Colors.black,
                                      title:
                                      "هل أنت متأكد من أنك تريد حذف هذا الطلب",
                                      weight: FontWeight.bold),
                                  actions: <Widget>[
                                    // usually buttons at the bottom of the dialog
                                    MaterialButton(
                                      minWidth: 50,
                                      color: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(4)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        child: Text("حذف",
                                            style: TextStyle(
                                                fontFamily: "pnuM",
                                                color: Colors.white)),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, 1);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "الغاء",
                                        style:
                                         TextStyle(fontFamily: "pnuM"),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context, 0);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).then((value) {
                            print(value);
                            if (value == null) {
                              return;
                            } else if (value == 1) {

                              if(onDelete){
                                OrderCubit.get(context).deleteOrder(status: 0,
                                    context: context, id: list[index].order!.id);
                              }else{
                                OrderCubit.get(context).deleteOrder(status:1,
                                    context: context, id: list[index].order!.id);
                              }

                            }
                          });
                        },
                        child: const Center(
                          child: CustomText(
                            text: "حذف",
                            size: 14,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ))
                  ]);
                })),
          ],
        ),
      ),
    );
  }

  Future showDialogAction(int id, BuildContext context, String name) async {
    showDialog(
      context: context,
      builder: (context) {
        // return object of type Dialog
        return Container(
          // height: 200,
          child: AlertDialog(
            title: Texts(
                fSize: 18,
                color: Colors.red,
                title: name,
                weight: FontWeight.bold),
            content: Texts(
                fSize: 20,
                color: Colors.black,
                title: "هل أنت متأكد من أنك تريد حذف هذا القسم",
                weight: FontWeight.bold),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              TextButton(
                child: const Text("حذف", style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              TextButton(
                child: const Text("الغاء"),
                onPressed: () {
                  Navigator.pop(context, 0);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
