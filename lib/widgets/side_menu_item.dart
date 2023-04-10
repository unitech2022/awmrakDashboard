import 'package:dashbordawamrak/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';

import '../helpers/reponsiveness.dart';
import 'horizontal_menu_item.dart';



class SideMenuItem extends StatelessWidget {
  final String itemName;
  final void  Function()? onTap;

  const SideMenuItem({ required this.itemName,required this.onTap }) ;

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomSize(context)){
      return VertticalMenuItem(itemName: itemName, onTap: onTap,);
    }else{
      return HorizontalMenuItem(itemName: itemName, onTap: onTap,);
    }
  }
}