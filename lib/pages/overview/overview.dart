import 'package:dashbordawamrak/bloc/app_cubit/app_cubit.dart';

import 'package:dashbordawamrak/pages/overview/widgets/available_drivers_table.dart';
import 'package:dashbordawamrak/pages/overview/widgets/overview_cards_large.dart';
import 'package:dashbordawamrak/pages/overview/widgets/overview_cards_medium.dart';
import 'package:dashbordawamrak/pages/overview/widgets/overview_cards_small.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';


class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppCubit.get(context).getHomeData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold, color: Colors.black,
                  )),
            ],
          ),
        ),
        AppCubit.get(context).load
            ? const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
            color: Colors.blue,
          ),
        ):  Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                OverviewCardsMediumScreen(AppCubit.get(context).homeModel)
              else
                OverviewCardsLargeScreen(AppCubit.get(context).homeModel)
            else
              OverviewCardsSmallScreen(AppCubit.get(context).homeModel),
            // if (!ResponsiveWidget.isSmallScreen(context))
            //   RevenueSectionLarge()
            // else
            //   RevenueSectionSmall(),

            const SizedBox(height: 10,),
              AvailableDriversTable(AppCubit.get(context).homeModel.orders!),

          ],
        ))
      ],
    );
  },
);
  }
}
