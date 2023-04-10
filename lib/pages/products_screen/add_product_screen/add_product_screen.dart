import 'dart:typed_data';

import 'package:dashbordawamrak/bloc/markets_cubit/markets_cubit.dart';
import 'package:dashbordawamrak/models/market.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/category_cubit/category_cubit.dart';
import '../../../bloc/products_cubit/product_cubit.dart';
import '../../../constants/constans.dart';
import '../../../constants/style.dart';
import '../../../helpers/functions.dart';
import '../../../models/producte_model.dart';
import '../../../widgets/CustomDropDownWidget.dart';
import '../../../widgets/buttons.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/fields.dart';
import '../../../widgets/texts.dart';

class AddProductScreen extends StatefulWidget {
  final Product producteModel;
  final int status;

  AddProductScreen(this.producteModel, this.status);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerDetails = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MarketsCubit.get(context).category = null;

    if (widget.status == 1) {
      getData();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerDetails.dispose();
    _controllerPrice.dispose();
  }

  String image = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: 450,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: Colors.black),
                            color: Colors.white),
                        padding: const EdgeInsets.all(20),
                        // height: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts(
                                    fSize: 20,
                                    color: Colors.black,
                                    title: "اضافة منتج جديد",
                                    weight: FontWeight.bold),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 25,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<MarketsCubit, MarketsState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Texts(
                                              fSize: 20,
                                              color: Colors.black,
                                              title: "القسم",
                                              weight: FontWeight.bold),
                                          CustomDropDownWidget(
                                              currentValue:
                                                  MarketsCubit.get(context)
                                                      .category,
                                              selectCar: false,
                                              colorBackRound:
                                                  const Color(0xffF6F6F6),
                                              textColor: Colors.black,
                                              isTwoIcons: false,
                                              iconColor:
                                                  const Color(0xff515151),
                                              icon2: Icons.add_box_outlined,
                                              icon1: Icons.search,
                                              list: MarketsCubit.get(context)
                                                  .markets
                                                  .map((item) =>
                                                      DropdownMenuItem<Object>(
                                                          value: item,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                item.name!,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                              // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                                              //   widget.actionBtn(item.id);
                                                              // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                                            ],
                                                          )))
                                                  .toList(),
                                              onSelect: (value) {
                                                MarketsCubit.get(context)
                                                    .changeValue(value);
                                              },
                                              hint: "اختار قسم"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    // Expanded(
                                    //   child: Column(
                                    //     crossAxisAlignment:
                                    //         CrossAxisAlignment.start,
                                    //     children: [
                                    //       Texts(
                                    //           fSize: 20,
                                    //           color: Colors.black,
                                    //           title: "Brand",
                                    //           weight: FontWeight.bold),
                                    //       CustomDropDownWidget(
                                    //           currentValue:
                                    //               CategoryCubit.get(context)
                                    //                   .brand,
                                    //           selectCar: false,
                                    //           colorBackRound:
                                    //               const Color(0xffF6F6F6),
                                    //           textColor: Colors.black,
                                    //           isTwoIcons: false,
                                    //           iconColor:
                                    //               const Color(0xff515151),
                                    //           icon2: Icons.add_box_outlined,
                                    //           icon1: Icons.search,
                                    //           list: CategoryCubit.get(context)
                                    //               .listBrands
                                    //               .map((item) =>
                                    //                   DropdownMenuItem<dynamic>(
                                    //                       value: item,
                                    //                       child: Row(
                                    //                         mainAxisAlignment:
                                    //                             MainAxisAlignment
                                    //                                 .spaceBetween,
                                    //                         children: [
                                    //                           Text(
                                    //                             item.name,
                                    //                             style:
                                    //                                 const TextStyle(
                                    //                               fontSize: 14,
                                    //                               fontWeight:
                                    //                                   FontWeight
                                    //                                       .bold,
                                    //                               color: Colors
                                    //                                   .black,
                                    //                             ),
                                    //                             overflow:
                                    //                                 TextOverflow
                                    //                                     .ellipsis,
                                    //                           ),
                                    //                           // if(widget.actionBtn!=null) IconButton(onPressed:(){
                                    //                           //   widget.actionBtn(item.id);
                                    //                           // } , icon: Icon(Icons.close,color: Colors.red,size: 20,))
                                    //                         ],
                                    //                       )))
                                    //               .toList(),
                                    //           onSelect: (value) {
                                    //             CategoryCubit.get(context)
                                    //                 .changeValueBrand(value);
                                    //           },
                                    //           hint: "اختار brand"),
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerName,
                              hint: "اسم المنتج",
                              inputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerDetails,
                              hint: "تفاصيل المنتج",
                              inputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField2(
                              controller: _controllerPrice,
                              hint: "االسـعر",
                              inputType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<CategoryCubit, CategoryState>(
                              listener: (context, state) {
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is UpdateCategoriesLoadedImageStat) {
                                  image = state.image;
                                  print("iiiiiiiiiiiiiiiiiiii$image");
                                }
                                return CategoryCubit.get(context).loadImage
                                    ? const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        ),
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              chooseFileUsingFilePicker()
                                                  .then((value) {
                                                CategoryCubit.get(context)
                                                    .uploadSelectedFile(
                                                        objFile: objFile)
                                                    .then((value) {});
                                              });
                                            },
                                            child: image == ""
                                                ? const Icon(
                                                    Icons.camera_alt,
                                                    size: 100,
                                                  )
                                                : Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      child: Image.network(
                                                        baseUrlImages + image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ],
                                      );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            (ProductCubit.get(context).loadAddProduct ||
                                    ProductCubit.get(context).loadUpdate)
                                ? const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.black,
                                  )
                                : CustomButton(
                                    color: homeColor,
                                    width: double.infinity,
                                    height: 45,
                                    onPress: () {
                                      // print("dh");

                                      // print(CategoryCubit.get(context).category.id);
                                      if (isValidate()) {
                                        if (widget.status == 0) {
                                          Product product = Product(
                                              status: 0,
                                              name: _controllerName.text.trim(),
                                              image: image,
                                              categoryId:
                                                  MarketsCubit.get(context)
                                                      .category!
                                                      .id!,
                                              price:
                                                  _controllerPrice.text.trim(),
                                              detail: _controllerDetails.text
                                                  .trim(),
                                              isSlider: true,
                                              city: MarketsCubit.get(context)
                                                  .category!
                                                  .city,
                                              homeCategoryId:
                                                  MarketsCubit.get(context)
                                                      .category!
                                                      .categoryId,
                                              sellerId:
                                                  MarketsCubit.get(context)
                                                      .category!
                                                      .userId);

                                          ProductCubit.get(context)
                                              .addProduct(product)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          Product product = Product(
                                              status: 0,
                                              name: _controllerName.text.trim(),
                                              image: image,
                                              categoryId:
                                                  MarketsCubit.get(context)
                                                      .category!
                                                      .id!,
                                              id: widget.producteModel.id,
                                              price:
                                                  _controllerPrice.text.trim(),
                                              detail: _controllerDetails.text
                                                  .trim(),
                                              isSlider: true,
                                              city: MarketsCubit.get(context)
                                                  .category!
                                                  .city,
                                              homeCategoryId:
                                                  MarketsCubit.get(context)
                                                      .category!
                                                      .categoryId,
                                              sellerId: widget
                                                  .producteModel.sellerId);

                                          ProductCubit.get(context)
                                              .updateProduct(product)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        }
                                      }
                                    },
                                    fontFamily: "",
                                    text:
                                        widget.status == 1 ? "تعديل" : "اضافة",
                                    isCustomColor: true,
                                    redius: 10,
                                    fontSize: 20,
                                    textColor: Colors.white,
                                    isBorder: true,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  late PlatformFile objFile;
  late Uint8List uploadedImage;

  Future chooseFileUsingFilePicker() async {
    //-----pick file by file picker,

    var result = await FilePicker.platform
        .pickFiles(
      withReadStream:
          true, // this will return PlatformFile object with read stream
    )
        .then((value) {
      if (value != null) {
        setState(() {
          objFile = value.files.single;

          print(objFile.name);
        });
      }
    });
    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
    }
  }

  bool isValidate() {
    if (MarketsCubit.get(context).category == null) {
      HelperFunctions.slt.notifyUser(
          message: "اختار القسم", color: Colors.blue, context: context);
      return false;
    } else if (_controllerName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب اسم المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerDetails.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب تفاصيل المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerPrice.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب سعر المنتج", color: Colors.blue, context: context);
      return false;
    } else if (image == "") {
      HelperFunctions.slt.notifyUser(
          message: "اختار الصورة", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }

  void getData() {
    MarketsCubit.get(context).category = MarketsCubit.get(context)
        .markets
        .firstWhere((element) => element.id == widget.producteModel.categoryId,
            orElse: () => MarketModel());

    // print(CategoryCubit.get(context).listCategories.length.toString() +"dddddddd");

    _controllerDetails.text = widget.producteModel.detail!;
    _controllerPrice.text = widget.producteModel.price.toString();
    _controllerName.text = widget.producteModel.name!;
    image = widget.producteModel.image!;
  }
}
