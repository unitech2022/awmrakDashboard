import 'package:cached_network_image/cached_network_image.dart';
import 'package:dashbordawamrak/bloc/products_cubit/product_cubit.dart';
import 'package:dashbordawamrak/models/market.dart';
import 'package:dashbordawamrak/models/producte_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants/constans.dart';
import '../../constants/style.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/texts.dart';


class ProductsScreen extends StatefulWidget {
  final MarketModel model;


  ProductsScreen(this.model);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
         print("object"+widget.model.id.toString());

    ProductCubit.get(context).getProductsByCategoryDio(widget.model.id!);


  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              child: Column(

                children: [




                  Expanded(
                    child: ProductCubit
                        .get(context)
                        .load
                        ? Container(
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 5,
                          color: Colors.blue,
                        ),
                      ),
                    )
                        : TableWidgetProduct(
                      model:widget.model
                      ,list: ProductCubit
                          .get(context)
                          .products,
                      name: "JDJDJD",
                      image: "HDDDDDDD",
                      id: "1",
                      label: "المنتجات",
                      onDelete: false,
                      onUpdate: false,
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}

class ConatinerDetailsMarket extends StatelessWidget{

  final String title, value;
  final IconData icon;
  final void Function() onPress;

  ConatinerDetailsMarket({required this.title, required this.value, required this.icon, required this.onPress});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        Text(title,
            style: const TextStyle(
                fontFamily: 'pnuB',
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w200)),
        const SizedBox(width: 10,)
        ,
        Expanded(
          child: Text(value,
              style: const TextStyle(
                  fontFamily: 'pnuB',
                  fontSize: 14,
                  color: Colors.green,
                  fontWeight: FontWeight.w200)),
        ),

        InkWell(
            onTap: onPress,
            child:  Icon(icon,size: 20,color: Colors.blue,))
      ],
    );
  }
}

class TableWidgetProduct extends StatelessWidget {
  final String label, name, id, image;
  final bool onUpdate, onDelete;
  final List<Product> list;
  final MarketModel model;

  TableWidgetProduct({required this.label,
    required this.name,
    required this.model,
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
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,


              ),
              child:   ClipRRect(

                child: CachedNetworkImage(
                  imageUrl: baseUrlImages + model.image!,
                  height: 200,
                  width:double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Container(
                        width: 25,
                        height: 25,
                        child: const CircularProgressIndicator(
                          color: Colors.green,
                        )),
                  ),
                  errorWidget: (context, url, error) => Container(
                      height: 100,
                      child: const Center(
                          child: Icon(
                            Icons.error,
                            size: 25,
                          ))),
                ),
              ),
            ),

            Text(model.name!,
                style: const TextStyle(
                    fontFamily: 'pnuB',
                    fontSize: 25,
                    color: homeColor,
                    fontWeight: FontWeight.w200)),

            Text(model.details!,
                style:  TextStyle(
                    fontFamily: 'pnuB',
                    fontSize: 14,
                    height: 1.2,
                    color: homeColor.withOpacity(.5),
                    fontWeight: FontWeight.w200)),
            const SizedBox(height: 20,),
            const Divider(height: 1,),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Text("تفاصيل المحل",
                          style: TextStyle(
                              fontFamily: 'pnuB',
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w200)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  ConatinerDetailsMarket(title: "العنوان : ",
                    onPress: (){},value: model.address!,icon: Icons.location_on_outlined,),

                  const SizedBox(height: 8,),
                  ConatinerDetailsMarket(title: "رقم الهاتف : ",
                    onPress: (){},value: model.phone!,icon: Icons.call,),
                  const SizedBox(height: 20,),
                  const Divider(height: 1,)
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                children: const [
                  Text("المنتجات",
                      style: TextStyle(
                          fontFamily: 'pnuB',
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.w200)),
                ],
              ),
            ),
            const SizedBox(height: 40),
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
                    label: Text('الوصف'),
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
                                              type: 1
                                            );
                                          }else{
                                            ProductCubit.get(context).updateStatusProduct(
                                                categoryId: list[index].categoryId,
                                                status: 0,id: list[index].id,
                                              type: 1
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
