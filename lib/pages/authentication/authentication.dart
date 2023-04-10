import 'package:dashbordawamrak/bloc/auth_cubit/auth_cubit.dart';
import 'package:dashbordawamrak/helpers/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../constants/style.dart';
import '../../routing/routes.dart';
import '../../widgets/buttons.dart';
import '../../widgets/custom_text.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage();

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _controllerEmail = TextEditingController();

  final _controllerPass = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerEmail.text="awamrak@admin.com";
    _controllerPass.text="Abc123@";
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: homeColor,
          body: Center(
            child: Container(
              height: 550,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(15)),
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          "assets/images/logo.jpg",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: const [
                      Text("أوامرك",
                          style: TextStyle(
                              color: homeColor,
                              fontFamily: "pnuB",
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: "أهلا بك في لوحة التحكم ..",
                        color: lightGrey,
                        size: 15,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: "pnuM"),
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                        labelText: "البريد الالكترونى",
                        hintText: "abc@domain.com",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    style: const TextStyle(fontFamily: "pnuM"),
                    obscureText: true,
                    controller: _controllerPass,
                    decoration: InputDecoration(
                        labelText: "الرقم السري",
                        hintText: "123",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       children: [
                  //         Checkbox(
                  //             value: AuthCubit.get(context).isChecked,
                  //             onChanged: (value) {
                  //               AuthCubit.get(context).changeCheckBox(value!);
                  //             }),
                  //         const CustomText(
                  //           text: "تذكرنى",
                  //           size: 16,
                  //           color: homeColor,
                  //           weight: FontWeight.bold,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),

                  SizedBox(
                    height: 45,
                    child: AuthCubit.get(context).loadLogin
                        ? const Center(
                            child:  CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : CustomButton(
                            color: homeColor,
                            width: double.infinity,
                            height: 45,
                            onPress: () {
                              // print("dh");
                              if (isValidate(context)) {
                                AuthCubit.get(context).loginUser(
                                    userName: _controllerEmail.text.trim(),
                                    pass: _controllerPass.text.trim(),
                                    onSuccess: () {
                                      Get.offAllNamed(rootRoute);
                                    });
                              }
                            },
                            fontFamily: "pnuB",
                            text: "دخول",
                            isCustomColor: true,
                            redius: 10,
                            fontSize: 20,
                            textColor: Colors.white,
                            isBorder: true,
                          ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  // RichText(text: TextSpan(
                  //   children: [
                  //     TextSpan(text: "Do not have admin credentials? "),
                  //     TextSpan(text: "Request Credentials! ", style: TextStyle(color: active))
                  //   ]
                  // ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidate(BuildContext context) {
    if (_controllerEmail.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل رقم الايميل");
      return false;
    } else if (_controllerPass.text.isEmpty) {
      HelperFunctions.slt.notifyUser(
          context: context, color: Colors.grey, message: "أدخل الرقم السري ");
      return false;
    } else {
      return true;
    }
  }
}
