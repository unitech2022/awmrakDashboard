import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../constants/controllers.dart';
import '../constants/style.dart';
import 'custom_text.dart';

class HorizontalMenuItem extends StatelessWidget {
    final String itemName;
  final void Function()? onTap;
  const HorizontalMenuItem({ required this.itemName, required this.onTap }) ;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return InkWell(
                  onTap: onTap,
                  onHover: (value){
                    value ?
                    menuController.onHover(itemName) : menuController.onHover("not hovering");
                  },
                  child: Obx(() => Container(
                    color: menuController.isHovering(itemName) ? lightGrey.withOpacity(.1) : Colors.transparent,
                    child: Row(
                      children: [
                        Visibility(
                          visible: menuController.isHovering(itemName) || menuController.isActive(itemName),
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Container(
                            width: 6,
                            height: 40,
                            color: Colors.red,
                          ),
                        ),
                       SizedBox(width:_width / 88),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: menuController.returnIconFor(itemName),
                        ),
                        if(!menuController.isActive(itemName))
                        Flexible(child: CustomText(text: itemName , color: menuController.isHovering(itemName) ? Colors.white : lightGrey, size: 16, weight: FontWeight.bold,))
                        else
                        Flexible(child: CustomText(text: itemName , color:  Colors.white , size: 18, weight: FontWeight.bold,))

                      ],
                    ),
                  ))
                );
  }
}