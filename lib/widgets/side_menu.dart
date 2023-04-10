import 'package:dashbordawamrak/helpers/function_helper.dart';
import 'package:dashbordawamrak/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import '../helpers/reponsiveness.dart';
import '../routing/routes.dart';
import 'custom_text.dart';

class SideMenu extends StatelessWidget {
  const SideMenu();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(

            color: homeColor,
        child: ListView(
          children: [
            if(ResponsiveWidget.isSmallScreen(context))
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height:80,
                  ),
                  Row(
                    children: [
                      SizedBox(width: _width / 48),
                      Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle
                        ),
                        child: ClipRRect(
                            borderRadius:   BorderRadius.circular(20),

                            child: Image.asset("assets/images/logo.jpg",width:40,height: 40,)),
                      ),
                      const Flexible(
                        child: CustomText(
                          text: "أوامراك",
                          size: 20,
                          weight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: _width / 48),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            Divider(color: lightGrey.withOpacity(.1), ),
            const SizedBox(
              height:30,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItemRoutes
                  .map((item) => SideMenuItem(
                  itemName: item.name,
                  onTap: () {
                    print("ssssssssss");
                    if(item.route == authenticationPageRoute){

                      logOut().then((value) {
                        Get.offAllNamed(authenticationPageRoute);
                        menuController.changeActiveItemTo(overviewPageDisplayName);
                      });


                    }
                    if (!menuController.isActive(item.name)) {
                      menuController.changeActiveItemTo(item.name);
                      if(ResponsiveWidget.isSmallScreen(context))
                        Get.back();
                      navigationController.navigateTo(item.route);
                    }
                  }))
                  .toList(),
            )
          ],
        )
          );
  }
}