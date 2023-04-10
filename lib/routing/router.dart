import 'package:dashbordawamrak/pages/admins_screen/admins_screen.dart';
import 'package:dashbordawamrak/pages/care_screen/care_screen.dart';
import 'package:dashbordawamrak/pages/products_screen/markets_screen.dart';
import 'package:dashbordawamrak/routing/routes.dart';
import 'package:flutter/material.dart';


import '../pages/category_screen/drivers.dart';
import '../pages/clients/clients.dart';
import '../pages/orders_screen/orders_screen.dart';
import '../pages/overview/overview.dart';
import '../pages/products_screen/products_screen.dart';
import '../pages/siting_screen/siting_screen.dart';
import '../pages/slider_screen/sliders_screen.dart';



Route<dynamic> generateRoute(RouteSettings settings){
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case driversPageRoute:
      return _getPageRoute(DriversPage());
    case productsPageRoute:
      return _getPageRoute(MarketsScreen());
    case brandsPageRoute:


      return _getPageRoute(const AdminsScreen());
    case slidersPageRoute:
      return _getPageRoute(const SlidersScreen());
    case ordersPageRoute:
      return _getPageRoute(const OrdersScreen());
    case caresPageRoute:
      return _getPageRoute(const CaresScreen());
    case clientsPageRoute:
      return _getPageRoute(const ClientsPage());
    case sittingPageRoute:
      return _getPageRoute(SittingScreen());
    default:
      return _getPageRoute(OverviewPage());

  }
}

PageRoute _getPageRoute(Widget child){
  return MaterialPageRoute(builder: (context) => child);
}