import 'dart:typed_data';

import 'package:dashbordawamrak/bloc/auth_cubit/auth_cubit.dart';
import 'package:dashbordawamrak/bloc/user_cubit/user_cubit.dart';
import 'package:dashbordawamrak/helpers/function_helper.dart';
import 'package:dashbordawamrak/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/category_cubit/category_cubit.dart';
import '../../constants/constans.dart';
import '../../constants/style.dart';
import '../../helpers/functions.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fields.dart';
import '../../widgets/texts.dart';

class AddAdminScreen extends StatefulWidget {


  AddAdminScreen();

  @override
  State<AddAdminScreen> createState() => _AddAdminScreenState();
}

class _AddAdminScreenState extends State<AddAdminScreen> {
    final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  String image = "";

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
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
                                  title: "اضافة مدير ",
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

                          CustomTextField2(
                            controller: _controllerName,
                            hint: "الاسم بالكامل",
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField2(
                            controller: _controllerEmail,
                            hint: "الايميل",
                            inputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextField2(
                            controller: _controllerPassword,

                            hint: "الرقم السرى لابد ان يحتوى علي احرف كبيرة وعلامات# @",
                            inputType: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // BlocConsumer<CategoryCubit, CategoryState>(
                          //   listener: (context, state) {
                          //     // TODO: implement listener
                          //   },
                          //   builder: (context, state) {
                          //     if (state is UpdateCategoriesLoadedImageStat) {
                          //       image = state.image;
                          //       print("iiiiiiiiiiiiiiiiiiii$image");
                          //     }
                          //     return CategoryCubit.get(context).loadImage
                          //         ? const SizedBox(
                          //       height: 40,
                          //       width: 40,
                          //       child: Center(
                          //         child: CircularProgressIndicator(
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //     )
                          //         : Row(
                          //       mainAxisAlignment:
                          //       MainAxisAlignment.center,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             chooseFileUsingFilePicker()
                          //                 .then((value) {
                          //               CategoryCubit.get(context)
                          //                   .uploadSelectedFile(
                          //                   objFile: objFile)
                          //                   .then((value) {});
                          //             });
                          //           },
                          //           child: image == ""
                          //               ? const Icon(
                          //             Icons.camera_alt,
                          //             size: 100,
                          //           )
                          //               : Container(
                          //             height: 100,
                          //             width: 100,
                          //             child: ClipRRect(
                          //               borderRadius:
                          //               BorderRadius.circular(
                          //                   5),
                          //               child: Image.network(
                          //                 baseUrlImages + image,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          (AuthCubit.get(context).isRegisterLoad
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
                              AuthCubit.get(context).registerUser(
                                userName: _controllerEmail.text.trim(),
                                role: "admin",
                                fullName: _controllerName.text,
                                email:_controllerEmail.text,
                                pass: _controllerPassword.text,
                                onSuccess: (){

                                   UserCubit.get(context).getUsers();
                                   pop(context);

                                }

                              );

                              }
                            },
                            fontFamily: "",
                            text:
                            "تسجيل ",
                            isCustomColor: true,
                            redius: 10,
                            fontSize: 20,
                            textColor: Colors.white,
                            isBorder: true,
                          ))
                        ],
                      ),
                    ),
                  ],
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
  if (_controllerName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب اسم المنتج", color: Colors.blue, context: context);
      return false;
    } else if (_controllerEmail.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الايميل", color: Colors.blue, context: context);
      return false;
    } else if (_controllerPassword.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الرقم السرى", color: Colors.blue, context: context);
      return false;
    }  else {
      return true;
    }
  }


}
