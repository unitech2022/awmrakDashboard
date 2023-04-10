import 'package:dashbordawamrak/pages/siting_screen/add_setting_screen.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../bloc/setting_bloc/setting_cubit.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/setting_model.dart';
import '../../widgets/custom_text.dart';

class SittingScreen extends StatefulWidget {
  const SittingScreen({Key? key}) : super(key: key);
  @override
  State<SittingScreen> createState() => _SittingScreenState();
}

class _SittingScreenState extends State<SittingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SettingCubit.get(context).getSitting();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
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
                          color: homeColor,
                          text: menuController.activeItem.value,
                          size: 24,
                          weight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
                          // Get.to(AddCategoryScreen(CategoryModel(), 0,5));
                          Get.to(AddSettingScreen(SittingModel(), 0));
                          // pushPage(
                          //     context: context,
                          //     page: AddCategoryScreen());
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CustomText(
                                text: "اضافة اعداد",
                                color: Colors.white,
                                weight: FontWeight.bold, size: 15,
                              ),
                              SizedBox(width: 10,),

                              Icon(Icons.add,color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: SettingCubit.get(context).load
                      ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      )
                      : TableWidgetSettings(
                          list: SettingCubit.get(context).sittings,
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

class TableWidgetSettings extends StatelessWidget {
  final String? label, name, id, image;
  final bool? onUpdate, onDelete;
  final List<SittingModel>? list;

  const TableWidgetSettings(
      {this.label,
      this.name,
      this.id,
      this.onDelete,
      this.onUpdate,
      this.image,
      this.list});

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
                    label: Text('القيمة'),
                  ),
                  DataColumn(
                    label: Text('تعديل'),
                  ),
                  // DataColumn(
                  //   label: Text('حذف'),
                  // ),
                ],
                rows: List<DataRow>.generate(list!.length, (index) {
                  return DataRow(cells: [
                    DataCell(CustomText(text: "${list![index].id}", size: 14, weight: FontWeight.normal, color: Colors.black,)),
                    DataCell(CustomText(text: list![index].name!,size: 14, weight: FontWeight.normal, color: Colors.black)),
                    DataCell(CustomText(text: list![index].value!,size: 14, weight: FontWeight.normal, color: Colors.black)),
                    DataCell(Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.green,
                        onPressed: () {
                              // showDialogAction(context,list[index]);
                          Get.to(AddSettingScreen(list![index], 1));
                        },
                        child: const Center(
                          child: CustomText(
                            text: "تعديل",
                            size: 14,
                            color: Colors.white,
                            weight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                    // DataCell(Container(
                    //   margin: EdgeInsets.symmetric(vertical: 5),
                    //   height: 50,
                    //   width: 80,
                    //   child: MaterialButton(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(4)),
                    //     color: Colors.red,
                    //     onPressed: () {
                    //       showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           // return object of type Dialog
                    //           return Container(
                    //             // height: 200,
                    //             child: AlertDialog(
                    //               title: Texts(
                    //                   fSize: 18,
                    //                   color: Colors.red,
                    //                   title: list[index].value,
                    //                   weight: FontWeight.bold),
                    //               content: Texts(
                    //                   fSize: 20,
                    //                   color: Colors.black,
                    //                   title:
                    //                       "هل أنت متأكد من أنك تريد حذف هذا القسم",
                    //                   weight: FontWeight.bold),
                    //               actions: <Widget>[
                    //                 // usually buttons at the bottom of the dialog
                    //                 MaterialButton(
                    //                   minWidth: 50,
                    //                   color: Colors.red,
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius:
                    //                           BorderRadius.circular(4)),
                    //                   child: Padding(
                    //                     padding: EdgeInsets.symmetric(
                    //                         horizontal: 15, vertical: 2),
                    //                     child: Text("حذف",
                    //                         style: const TextStyle(
                    //                             fontFamily: "pnuM",
                    //                             color: Colors.white)),
                    //                   ),
                    //                   onPressed: () {
                    //                     Navigator.pop(context, 1);
                    //                   },
                    //                 ),
                    //                 TextButton(
                    //                   child: Text(
                    //                     "الغاء",
                    //                     style: TextStyle(fontFamily: "pnuM"),
                    //                   ),
                    //                   onPressed: () {
                    //                     Navigator.pop(context, 0);
                    //                   },
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         },
                    //       ).then((value) {
                    //         print(value);
                    //         if (value == null) {
                    //           return;
                    //         } else if (value == 1) {
                    //           SettingCubit.get(context).deleteCategory(
                    //               context: context,
                    //               endPoint: "",
                    //               id: list[index].id,
                    //               status: 0);
                    //         }
                    //       });
                    //     },
                    //     child: Center(
                    //       child: CustomText(
                    //         text: "حذف",
                    //         color: Colors.white,
                    //         weight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ),
                    // )),
                  ]);
                })),
          ],
        ),
      ),
    );
  }


}
