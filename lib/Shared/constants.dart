import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:osol/shared/routing.dart';

// /*****************All End Point***********************/
///User
const String getCountryURL = "/guest/getAllCountries";
const String authRegisterURL = "/client/register";
const String authLoginURL = "/client/login";
const String verifyOTP = "/client/VerifyAccount";
const String resendOTP = "/client/resendVerifiyCode";
const String logOutURL = "/client/logout";
const String forgetPasswordURL = "/client/clientForgetPassword";
const String resetPasswordURL = "/client/clientResetPassword";
const String getBannerURL = "/client/Banners/getBanners";
const String getFeatureClientURL = "/client/Unit/getFeaturesUnit";
const String getPopularClientURL = "/client/Unit/getPopularsUnit";
const String getProfileDataURL = "/client/getProfile";
const String getAllCompanyDataURL = "/client/Company/getAllComapnies";
const String setSavedData = "/client/Favourite/toggFavourite";
const String getMyFavoriteDataURL = "/client/Favourite/MyFavouriteUnit";
const String sendMessageToServicesURL = "/client/Message/sendMessageToService";
const String createReviewClientURL = "/client/Review/store";
const String getAllReviewByUnitIdURL = "/client/Review/getReviewsByUnitId";
const String getAllUnitByIdURL = "/client/Unit/getUnitById";
const String getBannerGuestURL = "/guest/getBanners";
const String getFeatureURL = "/guest/getAllUnit";
const String getAllUnitsdetails = "/client/Unit/getAllUnit";
const String getAllCompanyUnitID = "/client/Company/getComapnyById";
const String getDetectedCompanyProjects = "/client/Company/getCompanyProject";
const String getCompanyReviewResponse = "/client/Review/getReviewsByCompanyId";
const String changeClientPass = "/client/clientChangPassword";
const String updateClientProfile = "/client/updateProfile";

///Company
const String authRegisterCompanyURL = "/company/register";
const String resendOTPCompanyURL = "/company/resendVerifiyCode";
const String verifyCompanyAccountURL = "/company/VerifyAccount";
const String logOutCompanyURL = "/company/logout";
const String updateProfileCompanyURL = "/company/updateProfile";
const String getProfileCompanyURL = "/company/getProfile";
const String getBannersURL = "/company/banner/getMyBanners";
const String getFeatureAndPopularUnitURL = "/company/unit/getMyUnits";
const String setUnitURL = "/company/unit/store";
const String addNewBannerURL = "/company/banner/store";
const String getMyProjectURL = "/company/project/getMyProjects";
const String addNewProjectURl = "/company/project/store";
const String companyProjectUpdatedURL = "/company/project/update";
const String deleteProjectURl = "/company/project/delete";
const String companyUnitUpdateURL = "/company/unit/update";
const String deleteUnitURL = "/company/unit/delete";
// /*****************************************************/

const Color kDarkGoldColor = Color(0xffBA8B31);
const Color kLightGoldColor = Color(0xffF3E184);
const Color kBGColor = Color(0xfff4f4f4);
const Gradient kGoldGradient =
    RadialGradient(colors: [kLightGoldColor, kDarkGoldColor], radius: 4);
BoxDecoration kBoxDecoration = BoxDecoration(
  border: Border.all(color: Colors.grey),
  borderRadius: BorderRadius.circular(10),
);

const DefaultErrorMessage = 'خطأ في الانترنت!';

String getAsset(String imageName) => 'assets/images/$imageName.png';

String getLottie(String lottie) => 'assets/lottie/$lottie.json';

// void showInternetErrorMessage ()=> showSna(DefaultErrorMessage, color: Colors.red);

String reformatTime(TimeOfDay value) {
  final reformatted = value.hour.toString().padLeft(2, '0') +
      ':' +
      value.minute.toString().padLeft(2, '0') +
      ':00';
  return reformatted;
}

String reformatDate(DateTime value) {
  if (value == null) return '';
  final reformatted = value.year.toString() +
      '-' +
      value.month.toString().padLeft(2, '0') +
      '-' +
      value.day.toString().padLeft(2, '0');
  return reformatted;
}

String get getCurrentTimeCustomized {
  final now = TimeOfDay.now();
  final time =
      '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:00';
  return time;
}

String get getTodayDateCustomized {
  final now = DateTime.now();
  final date =
      '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  return date;
}

class ColorManager {
  static Color DarkThemeBackGround = HexaColor.fromHexa("#313040");
  static Color DarkThemeBlackGround2 = HexaColor.fromHexa("#3D3A50");
  static Color chatGreyColor = HexaColor.fromHexa("#ECECEC");
  static Color firsthomemainicon = HexaColor.fromHexa("#939393");
  static Color startgraidentCompany = HexaColor.fromHexa("#EEE657");
  static Color endgraidentCompany = HexaColor.fromHexa("##2CC990");
  static Color personMoreIcon = HexaColor.fromHexa("#A3E4DB");
  static Color settingMoreIcon = HexaColor.fromHexa("#FED1EF");
  static Color circleFB = HexaColor.fromHexa("#3B5998");
  static Color CompareConatainer = HexaColor.fromHexa("#EBF3FF");
  static Color disabledButtons = HexaColor.fromHexa("#ADCFFF");
  static Color redHeartcolor = HexaColor.fromHexa("#EC1818");
  static Color starColor = HexaColor.fromHexa("#F9CA24");
  static Color OnBoardingScreen = HexaColor.fromHexa("#006AFF");
  static Color WhiteScreen = HexaColor.fromHexa("#FFFFFF");
  static Color activeBottomNav = HexaColor.fromHexa("#FFFFFF");
  static Color labelContainerIcon = HexaColor.fromHexa("#DEDEDE");
  static Color blackFontStyle = HexaColor.fromHexa("#151617");
  static Color TextOnbordingColorButton = HexaColor.fromHexa("#464646");
  static Color AppBarHomeColorIcon = HexaColor.fromHexa("#006AFF");
  static Color bottomNavBarColor = HexaColor.fromHexa("#818181");
  static Color AppBarIconcolorGrey = HexaColor.fromHexa("#818181");
  static Color TextHomeColor = HexaColor.fromHexa("#464646");
  static Color onboardingColorDots = HexaColor.fromHexa("#006AFF");
  static Color onboardingColorDotsNotActive = HexaColor.fromHexa("#DEDEDE");
  static Color GreyColortext = HexaColor.fromHexa("#818181");
  static Color whatsColor = HexaColor.fromHexa("#29A71A");
  static Color telegramBTn = HexaColor.fromHexa("#009F8B");
  static Color homeColorFeature = HexaColor.fromHexa("#C6DEFE");
}

extension HexaColor on Color {
  static Color fromHexa(hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}

double sizeFromHeight(double fraction, {bool removeAppBarSize = true}) {
  MediaQueryData mediaQuery = MediaQuery.of(MagicRouter.currentContext);
  fraction = (removeAppBarSize
          ? (mediaQuery.size.height -
              AppBar().preferredSize.height -
              mediaQuery.padding.top)
          : (mediaQuery.size.height)) /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

double sizeFromWidth(double fraction) {
  fraction = MediaQuery.of(MagicRouter.currentContext).size.width /
      (fraction == 0 ? 1 : fraction);
  return fraction;
}

String googleMapsApiKeys = "AIzaSyD4BfBM9coQMwggb811oOO1_IGjBorAhgY";

String BASE_URL = "http://estategps.com/public";
