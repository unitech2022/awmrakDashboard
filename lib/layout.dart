import 'package:dashbordawamrak/widgets/large_screen.dart';
import 'package:dashbordawamrak/widgets/side_menu.dart';
import 'package:flutter/material.dart';



import 'helpers/local_navigator.dart';
import 'helpers/reponsiveness.dart';
import 'widgets/top_nav.dart';


class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar:  topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: ResponsiveWidget(
        largeScreen: const LargeScreen(),
      smallScreen: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator(),
      )
      ),
    );
  }
}
