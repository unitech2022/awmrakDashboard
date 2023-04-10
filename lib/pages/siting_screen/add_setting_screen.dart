import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../bloc/setting_bloc/setting_cubit.dart';
import '../../helpers/functions.dart';
import '../../models/setting_model.dart';
import '../../widgets/buttons.dart';
import '../../widgets/fields.dart';
import '../../widgets/texts.dart';

class AddSettingScreen extends StatefulWidget {

  SittingModel categoryModel;
  int status;


  AddSettingScreen(this.categoryModel, this.status);

  @override
  State<AddSettingScreen> createState() => _AddSettingScreenState();
}

class _AddSettingScreenState extends State<AddSettingScreen> {

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerValue = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.status == 1) {
      _controllerName.text = widget.categoryModel.name!;
     _controllerValue.text=widget.categoryModel.value!;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerValue.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {


        return Scaffold(
          body: Center(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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

                        Texts(
                            fSize: 20,
                            color: Colors.black,
                            title: widget.status == 1
                                ? "تعديل "
                                : "اضافة اعداد جديد",
                            weight: FontWeight.bold),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerName,
                          hint: "العنوان ",
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField2(
                          controller: _controllerValue,
                          hint: "القيمة ",
                          inputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        (SettingCubit
                            .get(context)
                            .loadAdd || SettingCubit
                            .get(context)
                            .loadUpdate)
                            ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        )
                            : CustomButton(
                          color: Colors.blue,
                          width: double.infinity,
                          height: 50,
                          onPress: () {
                            // print("dh");
                            if (isValidate()) {


                              if(widget.status==0){
                                SittingModel sitting=
                                SittingModel(
                                    name: _controllerName.text,
                                    value: _controllerValue.text
                                );
                                SettingCubit.get(context).addSitting(
                                  status: 0,
                                  endPoint: "sitting/add-sitting",
                                setting:sitting
                                ).then((value){
                                  Navigator.pop(context);
                                });
                              }
                              else {

                                SittingModel sitting=
                                SittingModel(
                                    name: _controllerName.text,
                                    value: _controllerValue.text,
                                  id: widget.categoryModel.id
                                );

                                print(sitting.name!+">>>>>>>>"+sitting.value!);

                                SettingCubit.get(context).updateCategory(
                                    status: 1,
                                    endPoint: "sitting/update-sitting",
                                    sitting:sitting
                                ).then((value){
                                  Navigator.pop(context);
                                });

                              }
                            }
                          },
                          fontFamily: "",
                          text: widget.status == 1 ? "تعديل" : "اضافة",
                          isCustomColor: true,
                          redius: 0,
                          fontSize: 20,
                          textColor: Colors.white,
                          isBorder: true,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  bool isValidate() {
    if (_controllerName.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب الاسم ",
          color: Colors.blue,
          context: context);
      return false;
    } else if (_controllerValue.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          message: "اكتب القيمة", color: Colors.blue, context: context);
      return false;
    } else {
      return true;
    }
  }
}
