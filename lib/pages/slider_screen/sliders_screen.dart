import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../bloc/category_cubit/category_cubit.dart';
import '../../bloc/markets_cubit/markets_cubit.dart';
import '../../bloc/products_cubit/product_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/category_model.dart';
import '../../models/producte_model.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';
import '../category_screen/add_category_screen/add_category_screen.dart';
import '../category_screen/drivers.dart';
import '../products_screen/add_product_screen/add_product_screen.dart';

class SlidersScreen extends StatefulWidget {
  const SlidersScreen();

  @override
  State<SlidersScreen> createState() => _SlidersScreenState();
}

class _SlidersScreenState extends State<SlidersScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketsCubit.get(context).getMarkets();
    ProductCubit.get(context).getSliders();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
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
                        weight: FontWeight.bold, color: homeColor,
                      )),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    width: 80,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: homeColor,
                      onPressed: () {
                         Get.to(AddProductScreen(Product(),0));

                        // pushPage(
                        //     context: context,
                        //     page: AddCategoryScreen());
                      },
                      child: const Center(
                        child: CustomText(
                          text: "اضافة منتج",
                          color: Colors.white,
                          weight: FontWeight.bold, size: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: ProductCubit.get(context).loadSlider
                    ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                )
                    : TableWidgetProductSlider(
                  list: ProductCubit.get(context).sliders,
                  name: "JDJDJD",
                  image: "HDDDDDDD",
                  id: "1",
                  label: "المنتجات",
                  onDelete: false,
                  onUpdate: false,
                )),
          ],
        );
      },
    );
  }
}

class TableWidgetProductSlider extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Product> list;

  TableWidgetProductSlider(
      {required this.label,
        required this.name,
        required this.id,
        required this.onDelete,
        required this.onUpdate,
        required this.image,
        required this.list}) ;


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
                    label: Text("Id"),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('الاسم'),
                  ),
                  DataColumn(
                    label: Text('الصورة'),
                  ),

                  DataColumn(
                    label: Text('الحالة'),
                  ),
                  DataColumn(
                    label: Text('تعديل'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                        (index) =>
                        DataRow2(
                            onTap: () {
                              // Get.to(ProductsScreen(list[index]));
                            },
                            cells: [
                              DataCell(CustomText(
                                text: "${list[index].id}",
                                weight: FontWeight.bold,
                                size: 16,
                                color: Colors.black,
                              )),
                              DataCell(CustomText(
                                text: list[index].name!,
                                weight: FontWeight.bold,
                                size: 16,
                                color: Colors.black,
                              )),
                              DataCell(Container(
                                width: 80,
                                height: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    "$baseUrlImages${list[index].image}",
                                    height: 60,
                                    width: 100,
                                    placeholder: (context, url) =>
                                    const Center(
                                        child:
                                        const CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              )),
                              DataCell(

                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    height: 50,
                                    width: 80,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)),
                                      color: Colors.green,
                                      onPressed: () {

                                        Get.to(AddProductScreen(list[index],1));

                                      },
                                      child:  const Center(
                                        child: CustomText(
                                          text:"تعديل",
                                          color: Colors.white,
                                          weight: FontWeight.bold,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )),
                              DataCell(

                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    height: 50,
                                    width: 80,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)),
                                      color:list[index].status==0?Colors.red: Colors.green,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            // return object of type Dialog
                                            return AlertDialog(
                                              title: Texts(
                                                  fSize: 18,
                                                  color: Colors.red,
                                                  title: list[index].name,
                                                  weight: FontWeight.bold),
                                              content: Texts(
                                                  fSize: 20,
                                                  color: Colors.black,
                                                  title:list[index].status==0?
                                                  "هل أنت متأكد من أنك تريد تفعيل هذا المنتج"
                                                      :
                                                  "هل أنت متأكد من أنك تريد وقف هذا المنتج"
                                                  ,
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
                                                        horizontal: 15,
                                                        vertical: 2),
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
                                                    style: TextStyle(
                                                        fontFamily: "pnuM"),
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
                                          } else if (value == 1) {}

                                          if(list[index].status==0){

                                            ProductCubit.get(context).updateStatusProduct(
                                                categoryId: list[index].categoryId,
                                                status: 1,id: list[index].id,
                                              type:0
                                            );
                                          }else{
                                            ProductCubit.get(context).updateStatusProduct(
                                                categoryId: list[index].categoryId,
                                                status: 0,id: list[index].id,
                                                type:0
                                            );
                                          }

                                        });


                                      },
                                      child:  Center(
                                        child: CustomText(
                                          text:list[index].status==0? "موقوف":"مفعل",
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
                                        return AlertDialog(
                                          title: Texts(
                                              fSize: 18,
                                              color: Colors.red,
                                              title: list[index].name,
                                              weight: FontWeight.bold),
                                          content: Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title:
                                              "هل أنت متأكد من أنك تريد حذف هذا المنتج",
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
                                                    horizontal: 15,
                                                    vertical: 2),
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
                                                style: TextStyle(
                                                    fontFamily: "pnuM"),
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

                                        ProductCubit.get(context)
                                            .deleteProduct(id: list[index].id,context: context);
                                      }
                                    });
                                  },
                                  child: const Center(
                                    child: CustomText(
                                      text: "حذف",
                                      color: Colors.white,
                                      weight: FontWeight.bold,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              )),
                            ]))),
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
