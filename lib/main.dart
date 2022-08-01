import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osol/Company/businessLogicLayer/authCompany/auth_company_cubit.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/popularList/popular_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:osol/User/BussinssLogic/customerServicesCubit/customer_services_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/savedCubit/saved_cubit.dart';
import 'package:osol/User/PresentaionLayer/OnboardingScreen/splash.dart';
import 'package:osol/shared/routing.dart';
import 'Company/PresentationLayer/DawerScreen/view.dart';
import 'Company/businessLogicLayer/addNewProjectCubit/add_new_projects_cubit.dart';
import 'Company/businessLogicLayer/blocObserver/blocObserver.dart';
import 'Company/businessLogicLayer/compayProject/company_project_cubit.dart';
import 'Company/businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'User/DataLayer/DataProvider/dioHelper.dart';
import 'User/DataLayer/localDataLayer/localData.dart';
import 'User/PresentaionLayer/DawerScreen/view.dart';
import 'User/PresentaionLayer/RegisterScreen/otpScreen/view.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await Shared.initSharedPref();
  final companyToken = await Shared.prefGetString(key: "CompanyTokenVerify");
  final isDarkMode = await Shared.prefGetBoolen(key: "isDark");
  final accessType = await Shared.prefGetString(key: "accessType");
  HttpOverrides.global = MyHttpOverrides();
  BlocOverrides.runZoned(
    () {
      runApp(
        MyApp(
          token: companyToken,
          accessType: accessType,
          darkMode: isDarkMode,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  String? token;
  String? accessType;
  bool? darkMode;

  MyApp({this.token, this.accessType, this.darkMode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilterCubit(),
      child: Builder(builder: (context) {
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => HomeCubit(
                      context: context, accessType: accessType, token: token)
                    ..getDataOfHome()),
              BlocProvider(
                  create: (context) =>
                      CommonCubit(accessType: accessType, token: token)
                        ..getCountry()),
              BlocProvider(
                  create: (context) =>
                      AuthCubit(accessType: accessType, token: token)),
              BlocProvider(
                create: (context) =>
                    ProfileCubit(accessType: accessType, token: token)
                      ..getProfileData(),
              ),
              BlocProvider(
                create: (context) => CompanyCubit(),
              ),
              BlocProvider(
                create: (context) => SavedCubit(),
              ),
              BlocProvider(
                create: (context) => CustomerServicesCubit(),
              ),
              BlocProvider(
                create: (context) => UnitClientCubit(),
              ),
              BlocProvider(
                  create: (context) => AppSettingCubit()
                    ..chandeDarkMode(darkMode != null ? darkMode : false)),

              ///company
              BlocProvider(create: (context) => AuthCompanyCubit()),
              BlocProvider(
                  create: (context) => BannersCubit()..getAllBanners()),
              BlocProvider(create: (context) => UnitCubit()..getAllFunction()),
              BlocProvider(
                  create: (context) =>
                      PopularCubit()..getDetectedPopularList()),
              BlocProvider(
                  create: (context) =>
                      ProfileCompanyCubit()..getProfileCompany()),
              BlocProvider(
                  create: (context) =>
                      CompanyProjectCubit()..getAllCompanyProjects()),
              BlocProvider(create: (context) => AddNewProjectsCubit()),
            ],
            child: BlocBuilder<AppSettingCubit, AppSettingState>(
              builder: (context, state) {
                return ScreenUtilInit(
                  designSize: Size(375, 812),
                  builder: (BuildContext context, child) => MaterialApp(
                    navigatorKey: navigatorKey,
                    onGenerateRoute: onGenerateRoute,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        appBarTheme: AppBarTheme(
                          backgroundColor: Colors.white,
                          backwardsCompatibility: false,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarBrightness: Brightness.light,
                            statusBarColor: Colors.white,
                            statusBarIconBrightness: Brightness.dark,
                          ),
                          elevation: 0,
                        ),
                        textTheme: TextTheme(
                            headline1: TextStyle(
                              color: ColorManager.TextHomeColor,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                            headline5: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: ColorManager.TextHomeColor,
                            ),
                            headline2: TextStyle(
                              color: ColorManager.blackFontStyle,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            headline3: TextStyle(
                              color: ColorManager.blackFontStyle,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            headline4: TextStyle(
                                color: ColorManager.firsthomemainicon,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            headline6: TextStyle(
                                color: ColorManager.firsthomemainicon,
                                fontWeight: FontWeight.bold,
                                fontSize: 6)),
                        iconTheme: IconThemeData(color: Colors.black),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          backgroundColor: Colors.white,
                        ),
                        scaffoldBackgroundColor: Colors.white),
                    darkTheme: ThemeData(
                        appBarTheme: AppBarTheme(
                          backgroundColor: ColorManager.DarkThemeBackGround,
                          backwardsCompatibility: false,
                          systemOverlayStyle: SystemUiOverlayStyle(
                            statusBarBrightness: Brightness.dark,
                            statusBarColor: ColorManager.DarkThemeBackGround,
                            statusBarIconBrightness: Brightness.light,
                          ),
                          elevation: 0,
                        ),
                        primaryColor: ColorManager.DarkThemeBackGround,
                        textTheme: TextTheme(
                            headline1: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                            ),
                            headline5: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            headline2: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            headline3: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            headline4: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            headline6: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 6)),
                        backgroundColor: ColorManager.DarkThemeBackGround,
                        iconTheme: IconThemeData(color: Colors.white),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                          backgroundColor: ColorManager.DarkThemeBackGround,
                        ),
                        scaffoldBackgroundColor:
                            ColorManager.DarkThemeBackGround),
                    themeMode: AppSettingCubit.get(context).isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    initialRoute: '/',
                    routes: {
                      '/': (context) => accessType == null
                          ? SplashScreen()
                          : accessType == "company"
                              ? NavigationDrawerCompany()
                              : NavigationDrawer(token: token.toString()),
                    },
                  ),
                );
              },
            ));
      }),
    );
  }
}
