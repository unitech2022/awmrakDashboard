
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashbordawamrak/bloc/markets_cubit/markets_cubit.dart';
import 'package:dashbordawamrak/bloc/user_cubit/user_cubit.dart';
import 'package:dashbordawamrak/helpers/function_helper.dart';

import 'package:dashbordawamrak/models/user_model.dart';
import 'package:dashbordawamrak/pages/add_admin_screen/add_admin_screen.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constants/constans.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';


class AdminsScreen extends StatefulWidget {
  const AdminsScreen() ;

  @override
  State<AdminsScreen> createState() => _AdminsScreenState();
}

class _AdminsScreenState extends State<AdminsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MarketsCubit.get(context).getMarkets();
UserCubit.get(context).getUsers();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
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
                          Get.to(AddAdminScreen());

                          // pushPage(
                          //     context: context,
                          //     page: AddCategoryScreen());
                        },
                        child: const Center(
                          child: CustomText(
                            text: "اضافة مدير",
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
                  child: UserCubit.get(context).loadUsers
                      ? const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      )
                      : TableWidgetProductSlider(
                    list: UserCubit.get(context).listAdmins,
                    name: "JDJDJD",
                    image: "HDDDDDDD",
                    id: "1",
                    label: "المنتجات",
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

class TableWidgetProductSlider extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<UserModel> list;

  TableWidgetProductSlider(
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
                    label: Text("Id"),
                    size: ColumnSize.L,
                  ),
                  DataColumn(
                    label: Text('الاسم'),
                  ),
                  DataColumn(
                    label: Text('الصورة'),
                  ),
                  /*DataColumn(
                    label: Text('الوصف'),
                  ),*/
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
                                text: list[index].userName!,
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
                                    "$baseUrlImages${list[index].imageUrl}",
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
                            /*  DataCell(

                                  Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    height: 50,
                                    width: 80,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4)),
                                      color: Colors.green,
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
                                                  "هل أنت متأكد من أنك تريد تفعيل هذا المدير"
                                                      :
                                                  "هل أنت متأكد من أنك تريد وقف هذا المدير"
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
                                                status: 1,id: list[index].id
                                            );
                                          }else{
                                            ProductCubit.get(context).updateStatusProduct(
                                                categoryId: list[index].categoryId,
                                                status: 0,id: list[index].id
                                            );
                                          }

                                        });

                                      },
                                      child:  const Center(
                                        child: CustomText(
                                          text:"مفعل",
                                          color: Colors.white,
                                          weight: FontWeight.bold,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )),*/
                              DataCell(list[index].id==currentUser.id?SizedBox():  Container(
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
                                              title: list[index].fullName,
                                              weight: FontWeight.bold),
                                          content: Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title:
                                              "هل أنت متأكد من أنك تريد حذف هذا المدير",
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

                                        UserCubit.get(context)
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


/*      BlocConsumer<CategoryCubit, CategoryState>(
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
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      width: 80,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: homeColor,
                        onPressed: () {
                          Get.to(AddCategoryScreen(CategoryModel(), 2,0));

                          // pushPage(
                          //     context: context,
                          //     page: AddCategoryScreen());
                        },
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "اضافة Brand",
                                color: Colors.white,
                                weight: FontWeight.bold,
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
              SizedBox(height: 10),
              Expanded(
                  child: CategoryCubit.get(context).loadBrands
                      ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                        color: Colors.blue,
                      ),
                    ),
                  )
                      : TableWidgetBrands(
                    list: CategoryCubit.get(context).listBrands,
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

class TableWidgetBrands extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<CategoryModel> list;

  TableWidgetBrands(
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
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(.1),
                blurRadius: 12)
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
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
                columns: [
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
                    label: Text('تعـديل'),
                  ),
                  DataColumn(
                    label: Text('حذف'),
                  ),
                ],
                rows: List<DataRow>.generate(
                    list.length,
                        (index) => DataRow(cells: [
                      DataCell(CustomText(text: "${list[index].id}")),
                      DataCell(CustomText(text: list[index].name)),
                      DataCell(Container(
                        child: Container(
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: CachedNetworkImage(
                              imageUrl:
                              "$baseUrlImages${list[index].image}",
                              height: 60,
                              width: 100,
                              placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                      )),
                      DataCell(Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        height: 50,
                        width: 80,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          color: Colors.green,
                          onPressed: () {
                          Get.to(AddCategoryScreen(list[index], 1,2));
                          },
                          child: Center(
                            child: CustomText(
                              text: "تعديل",
                              color: Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                      DataCell(Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
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
                                        title: list[index].name,
                                        weight: FontWeight.bold),
                                    content: Texts(
                                        fSize: 20,
                                        color: Colors.black,
                                        title:
                                        "هل أنت متأكد من أنك تريد حذف هذا القسم",
                                        weight: FontWeight.bold),
                                    actions: <Widget>[
                                      // usually buttons at the bottom of the dialog
                                      MaterialButton(
                                        minWidth: 50,
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(4)),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 2),
                                          child: Text("حذف",
                                              style: const TextStyle(
                                                  fontFamily: "pnuM",
                                                  color: Colors.white)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context, 1);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
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
                                CategoryCubit.get(context).deleteCategory(status: 1,
                                    context: context, id: list[index].id,endPoint: "brand/delete-brand");
                              }
                            });
                          },
                          child: Center(
                            child: CustomText(
                              text: "حذف",
                              color: Colors.white,
                              weight: FontWeight.bold,
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
                child: Text("حذف", style: const TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.pop(context, 1);
                },
              ),
              TextButton(
                child: Text("الغاء"),
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
}*/
