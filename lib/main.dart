import 'package:dashbordawamrak/bloc/auth_cubit/auth_cubit.dart';
import 'package:dashbordawamrak/bloc/care_bloc/care_cubit.dart';
import 'package:dashbordawamrak/bloc/markets_cubit/markets_cubit.dart';
import 'package:dashbordawamrak/pages/authentication/authentication.dart';
import 'package:dashbordawamrak/pages/overview/overview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/app_cubit/app_cubit.dart';
import 'bloc/category_cubit/category_cubit.dart';
import 'bloc/order_cubit/order_cubit.dart';
import 'bloc/products_cubit/product_cubit.dart';
import 'bloc/setting_bloc/setting_cubit.dart';
import 'bloc/user_cubit/user_cubit.dart';
import 'constants/style.dart';
import 'controllers/menu_controller.dart';
import 'controllers/navigation_controller.dart';
import 'helpers/function_helper.dart';
import 'layout.dart';
import 'routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MenuController());
  Get.put(NavigationController());
  await readToken();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/translations",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: Phoenix(child: MyApp())),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingCubit>(
          create: (BuildContext context) => SettingCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<CareCubit>(
          create: (BuildContext context) => CareCubit(),
        ),
        BlocProvider<AppCubit>(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider<CategoryCubit>(
          create: (BuildContext context) => CategoryCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<OrderCubit>(
          create: (BuildContext context) => OrderCubit(),
        ),
        BlocProvider<UserCubit>(
          create: (BuildContext context) => UserCubit(),
        ),
        BlocProvider<MarketsCubit>(
          create: (BuildContext context) => MarketsCubit(),
        )
      ],
      child: GetMaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        initialRoute: authenticationPageRoute,
        // unknownRoute: GetPage(
        //     name: '/not-found',
        //     page: () => PageNotFound(),
        //     transition: Transition.fadeIn),
        getPages: [
          GetPage(
              name: rootRoute,
              page: () {
                return SiteLayout();
              }),
          isRegistered()
              ? GetPage(name: overviewPageRoute, page: () => OverviewPage())
              : GetPage(
                  name: authenticationPageRoute,
                  page: () => const AuthenticationPage()),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Dashboard',
        theme: ThemeData(
          fontFamily: "pnuM",
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          }),
          primarySwatch: Colors.blue,
        ),
        // home: AuthenticationPage(),
      ),
    );
  }
}
