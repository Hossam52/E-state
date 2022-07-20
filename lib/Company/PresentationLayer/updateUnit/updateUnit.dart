import 'dart:io';
import 'package:intl/intl.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/HomeScreen/mapGetLocation.dart';
import 'package:osol/Company/PresentationLayer/addBanner/view.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/countryModel/modelOfData.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UpdateUnitInCompanyScreen extends StatefulWidget {
  @override
  State<UpdateUnitInCompanyScreen> createState() =>
      _UpdateUnitInCompanyScreenState();
}

class _UpdateUnitInCompanyScreenState extends State<UpdateUnitInCompanyScreen> {
  List<XFile>? imageFileList = [];

  void ImagePick() async {
    imageFileList!.clear();
    try {
      final List<XFile>? imagePick = await ImagePicker().pickMultiImage();
      if (imagePick!.isNotEmpty) {
        imageFileList!.addAll(imagePick);
      }
      debugPrint("ImageLength: ${imageFileList!.length}");
      setState(() {});
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    return File(imagePath).copy(image.path);
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController priceCntroller = TextEditingController();
  TextEditingController depositController = TextEditingController();
  TextEditingController downPaymentController = TextEditingController();
  TextEditingController monthlyPaymentController = TextEditingController();
  TextEditingController numberOfYearController = TextEditingController();
  TextEditingController yearBuildController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController videoURLController = TextEditingController();

  //Distance controller
  TextEditingController trainController = TextEditingController();
  TextEditingController busController = TextEditingController();
  TextEditingController metroController = TextEditingController();
  TextEditingController pharmacyController = TextEditingController();
  TextEditingController coffeController = TextEditingController();
  TextEditingController restaurantController = TextEditingController();
  TextEditingController bakaryController = TextEditingController();
  TextEditingController beachController = TextEditingController();

  navigateFun(context) {
    Navigator.pop(context);
  }

  imageChange() {
    imageFileList!.isNotEmpty
        ? UnitCubit.get(context).changeImageData(imageFile: imageFileList)
        : null;

    UnitCubit.get(context).imageData!.isNotEmpty
        ? UnitCubit.get(context).changeListData()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return WillPopScope(
          onWillPop: () {
            return navigateFun(context);
          },
          child: Scaffold(
            backgroundColor: ColorManager.WhiteScreen,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: ColorManager.WhiteScreen,
              toolbarHeight: 80,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black54,
                  size: 28,
                ),
              ),
              shape: ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              centerTitle: true,
              title: Text(
                "Update Unit",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15, left: 20, right: 20),
                    child: InkWell(
                      onTap: () => ImagePick(),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        height: sizeFromHeight(3),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: imageFileList!.isNotEmpty
                                    ? Image.file(
                                        File(imageFileList![0].path),
                                        fit: BoxFit.cover,
                                      )
                                    : SvgPicture.asset(
                                        "assets/images/imageunit.svg")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DetailsOfContains(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomTxtFieldAddUnit(
                      keyboardType: TextInputType.text,
                      controller: titleController,
                      hint: 'change name',
                      title: "Main Title",
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 20.0,
                //       vertical: 10,
                //     ),
                //     child: CustomdescriptionValueSelectList(
                //       title: "Description",
                //       myList: cubit.description,
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomrequiredFieldsValueSelectList(
                      title: "Uses",
                      myList: cubit.requiredFields,

                      ///required field
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomViewsValueSelectList(
                      title: "View",
                      myList: cubit.Views,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomAdsTypeValueSelectList(
                      title: "Ads Type",
                      myList: cubit.adsType,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustompurposeValueSelectList(
                      title: "Select Purpose",
                      myList: cubit.purpose,
                    ),
                  ),
                ),
                cubit.purposeValue == "Sale"
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomTxtFieldAddUnit(
                            controller: priceCntroller,
                            hint: 'Enter the Price',
                            title: "Price",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      )
                    : cubit.purposeValue == "Installment"
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CustomTxtFieldCompanyProfile(
                                      hint: "Deposite",
                                      title: "Deposite",
                                      controller: depositController,
                                      width: sizeFromWidth(2.4),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: CustomTxtFieldCompanyProfile(
                                      controller: numberOfYearController,
                                      hint: "1",
                                      title: "Number Of Years",
                                      width: sizeFromWidth(2.4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : cubit.purposeValue == "Rent"
                            ? SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: CustomTxtFieldCompanyProfile(
                                          controller: downPaymentController,
                                          hint: "Down Payment",
                                          title: "Down Payment",
                                          width: sizeFromWidth(2.4),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: CustomTxtFieldCompanyProfile(
                                          controller: monthlyPaymentController,
                                          hint: "Enter Your Month Payment",
                                          title: "Monthly Payment",
                                          width: sizeFromWidth(2.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : SliverToBoxAdapter(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomPaymenyMethodValueSelectList(
                      title: "Payment Method",
                      myList: cubit.paymentMethod,
                    ),
                  ),
                ),
                cubit.paymentMethodValue == "Installment"
                    ? SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: CustomTxtFieldCompanyProfile(
                                  hint: "Deposite",
                                  title: "Deposite",
                                  controller: depositController,
                                  width: sizeFromWidth(2.4),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                flex: 1,
                                child: CustomTxtFieldCompanyProfile(
                                  controller: numberOfYearController,
                                  hint: "1",
                                  title: "Number Of Years",
                                  width: sizeFromWidth(2.4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SliverToBoxAdapter(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomdropDownStyleTypeValueSelectList(
                      title: "Style Type",
                      myList: cubit.styleType,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20,
                      ),
                      child: CustomGetLocation("Location")),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: BlocBuilder<CommonCubit, CommonState>(
                      builder: (context, state) {
                        var cubit = CommonCubit.get(context);
                        return Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomSelectListRegister(
                                  myList: cubit.countryData == null
                                      ? []
                                      : cubit.countryData,
                                  title: "Country",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomSelectListCities(
                                  myList: cubit.cityData == null
                                      ? []
                                      : cubit.cityData,
                                  title: "City",
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomSelectListAreas(
                                  myList: cubit.areasData == null
                                      ? []
                                      : cubit.areasData,
                                  title: "Areas",
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomSelectRoomNumber(
                            "Rooms",
                            num: cubit.numRoom,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomSelectBathRoomNumber(
                              "Bathroom",
                              num: cubit.numBathRoom,
                            )),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomSelectFloorNumber(
                            "Floor",
                            num: cubit.numFloor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomSelectNumberOfYear(
                              "Year build",
                              controller: yearBuildController,
                            )),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomSelectNumberOfYear(
                            "Area",
                            controller: areaController,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            flex: 1,
                            child: CustomSelectBedRoomNumber(
                              "Bedrooms",
                              num: cubit.numBedRoom,
                            )),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CustomSelectListAvailable(
                            title: "Available",
                            myList: cubit.availableDate,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomSelectDate("Pick The Date"),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomfinishTypeValueSelectList(
                      title: "Finish Type",
                      myList: cubit.finishType,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomTxtFieldYoutubeAddUnit(
                      controller: videoURLController,
                      hint: "Enter the Link",
                      title: "Youtube Video Url",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: CustomOtherDataAddInCompany(),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20),
                    child: Container(
                      height: sizeFromHeight(10),
                      child: state is! SuccessGetImageData
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  maximumSize: Size(double.infinity, 50)),
                              onPressed: () async {
                                state is ChangeImageUnitState
                                    ? await cubit.changeListData()
                                    : print("Error");
                                cubit.updateUnit(
                                  context: context,
                                  add_type: cubit.adsTypeValue,
                                  air_condition:
                                      cubit.valueAirCondition ? "on" : null,
                                  area: areaController.text,
                                  area_id: "1",

                                  ///available take bool value 0/1
                                  available:
                                      cubit.availabe == "available" ? 1 : 0,
                                  available_date: cubit.title,
                                  bakary: cubit.BakaryDistance,
                                  balcony: cubit.valuebalcony ? "on" : null,
                                  bathroom: cubit.numBathRoom,
                                  beach: cubit.beachDistance,
                                  bedrooms: cubit.numBedRoom,
                                  bus: cubit.BusDistance,
                                  cable_tv: cubit.valueCableTV ? "on" : null,
                                  city_id: CommonCubit.get(context)
                                      .cityIndex
                                      .toString(),
                                  coffe: cubit.coffeDistance,
                                  computer: cubit.valueComputer ? "on" : null,
                                  country_id: CommonCubit.get(context)
                                      .valueCountryId
                                      .toString(),
                                  deposite: depositController.text,
                                  description: "vial",
                                  dishwasher:
                                      cubit.valueDishwasher ? "on" : null,
                                  down_payment:
                                      downPaymentController.text == null
                                          ? ""
                                          : downPaymentController.text,
                                  finished_type: cubit.finishTypeValue,
                                  floor: cubit.numFloor,
                                  gas_line: cubit.valueGasline ? "on" : null,
                                  grill: cubit.valueGrill ? "on" : null,
                                  heater: cubit.valueHeater ? "on" : null,
                                  internet: cubit.valueInternet ? "on" : null,
                                  lat: cubit.longitude,
                                  lift: cubit.valueLift ? "on" : null,
                                  long: cubit.latitude,
                                  metro: cubit.metroDistance,
                                  microwave: cubit.valueMicrowave ? "on" : null,
                                  monthly_payment:
                                      monthlyPaymentController.text == null
                                          ? ""
                                          : monthlyPaymentController.text,
                                  num_years: numberOfYearController.text,
                                  parking: cubit.valueParking ? "on" : null,
                                  payment_method: cubit.paymentMethodValue,
                                  pharmacy: cubit.pharmacyDistance,
                                  pool: cubit.valuePool ? "on" : null,
                                  price: priceCntroller.text,
                                  purpose: cubit.purposeValue,
                                  recption: null,
                                  required_fields: cubit.requiredFieldsValue,
                                  resturant: cubit.restDistance,
                                  rooms: cubit.numRoom,
                                  security: null,
                                  title: titleController.text,
                                  train: cubit.trainDistance,
                                  type: cubit.dropDownStyleTypeValue,
                                  video: videoURLController.text,
                                  view: cubit.ViewsValue,
                                  year_build: yearBuildController.text,
                                );
                                state is SuccessGetImageData
                                    ? Navigator.pop(context)
                                    : debugPrint("Error on Adding the value");
                              },
                              child: const Text(
                                "Save Changes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ListDetailsCompany extends StatelessWidget {
  String image;

  ListDetailsCompany({required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Container(
        height: sizeFromHeight(3.5),
        width: sizeFromWidth(1.3),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage("${image}"), fit: BoxFit.cover),
              ),
              height: sizeFromHeight(3),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOtherDataAddInCompany extends StatelessWidget {
  final PageController pageViewController = PageController();

  List Screen = [DistanceList(), IndoorList(), OutdoorList()];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Container(
            height: sizeFromHeight(1.25),
            width: sizeFromWidth(1.5),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: sizeFromHeight(1.5),
                          child: PageView.builder(
                              itemCount: Screen.length,
                              controller: pageViewController,
                              itemBuilder: (context, index) {
                                return Screen[index];
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            pageViewController.nextPage(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            child: cubit.currentDetailsScreen == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.black54,
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

///Screen
class DistanceList extends StatefulWidget {
  @override
  State<DistanceList> createState() => _DistanceListState();
}

class _DistanceListState extends State<DistanceList> {
  TextEditingController trainController = TextEditingController();

  TextEditingController metroController = TextEditingController();

  TextEditingController busController = TextEditingController();

  TextEditingController pharmacyController = TextEditingController();

  TextEditingController coffeController = TextEditingController();

  TextEditingController restController = TextEditingController();

  TextEditingController backeryController = TextEditingController();

  TextEditingController beachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Distance",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.trainSubway,
                  color: Colors.black54,
                ),
                title: Text("train"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToTrain(v);
                          },
                          controller: trainController,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset("assets/images/train.svg"),
                title: Text("Metro"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToMetro(v);
                          },
                          controller: metroController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.vanShuttle,
                  color: Colors.black54,
                ),
                title: Text("Bus"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToBus(v);
                          },
                          controller: busController,
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/pharmacy.svg",
                  color: Colors.black54,
                  width: 20,
                ),
                title: Text("Pharmacy"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToPharmacy(v);
                          },
                          controller: pharmacyController,
                          cursorColor: Colors.black54,
                          keyboardType: TextInputType.number,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/coffe.svg",
                  color: Colors.black54,
                  width: 20,
                ),
                title: Text("Coffe"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToCoffe(v);
                          },
                          keyboardType: TextInputType.number,
                          controller: coffeController,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/rest.svg",
                  color: Colors.black54,
                  width: 20,
                ),
                title: Text("Restaurant"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceRest(v);
                          },
                          keyboardType: TextInputType.number,
                          controller: restController,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/backery.svg",
                  color: Colors.black54,
                  width: 20,
                ),
                title: Text("Bakary"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToBakary(v);
                          },
                          keyboardType: TextInputType.number,
                          controller: backeryController,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  "assets/images/beach.svg",
                  color: Colors.black54,
                  width: 20,
                ),
                title: Text("Beach"),
                trailing: Container(
                  height: 40,
                  width: sizeFromWidth(4),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Colors.black54,
                            )),
                        height: sizeFromHeight(18),
                        width: sizeFromWidth(5.5),
                        child: TextFormField(
                          onChanged: (String v) {
                            cubit.changeDistanceToBeach(v);
                          },
                          keyboardType: TextInputType.number,
                          controller: beachController,
                          cursorColor: Colors.black54,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "M",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class IndoorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Indoor",
              style: TextStyle(
                  color: ColorManager.onboardingColorDots,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Air Condition',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueAirCondition,
                  onChanged: (value) {
                    cubit.changeAirConditionValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Cable Tv ',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueCableTV,
                  onChanged: (value) {
                    cubit.changeCableTVValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Computer',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueComputer,
                  onChanged: (value) {
                    cubit.changeComputerValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'GasLine',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueGasline,
                  onChanged: (value) {
                    cubit.changeGaslineValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'DishShawer',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueDishwasher,
                  onChanged: (value) {
                    cubit.changeDishwasherValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Internet',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueInternet,
                  onChanged: (value) {
                    cubit.changeInternetValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Heater',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                /** Checkbox Widget **/
                Checkbox(
                  value: cubit.valueHeater,
                  onChanged: (value) {
                    cubit.changeHeaterValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Microwave',
                  style: TextStyle(fontSize: 17.0),
                ), //Text
                Spacer(),
                Checkbox(
                  value: cubit.valueMicrowave,
                  onChanged: (value) {
                    cubit.changeMicrowaveValue(value!);
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
          ],
        );
      },
    );
  }
}

class OutdoorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = UnitCubit.get(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Outdoor",
            style: TextStyle(
                color: ColorManager.onboardingColorDots,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/balcony.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Balcony',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valuebalcony,
                onChanged: (value) {
                  cubit.changeBalconyValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 6,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/lift.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Lift',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueLift,
                onChanged: (value) {
                  cubit.changeLiftValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              //SizedBox
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    "assets/images/grill.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Grill',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueGrill,
                onChanged: (value) {
                  cubit.changeGrillValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/pool.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Pool',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valuePool,
                onChanged: (value) {
                  cubit.changePoolValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 10,
              ), //SizedBox
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/parking.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Parking',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ), //Text
              Spacer(),
              /** Checkbox Widget **/
              Checkbox(
                value: cubit.valueParking,
                onChanged: (value) {
                  cubit.changeParkingValue(value!);
                },
              ), //Checkbox
            ], //<Widget>[]
          ),
        ],
      ),
    );
  }
}

///
class DetailsOfContains extends StatelessWidget {
  const DetailsOfContains({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Container(
            height: sizeFromHeight(30),
            width: sizeFromWidth(1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: sizeFromWidth(2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.bath,
                        color: Colors.grey,
                        size: 12,
                      ),
                      Text("${cubit.numBathRoom}"),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.bed,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text("${cubit.numBedRoom}"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        OsolIcon.square_,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text("0 m²"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTxtFieldAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  TextInputType keyboardType;

  CustomTxtFieldAddUnit(
      {required this.title,
      required this.hint,
      required this.controller,
      required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                "0/150",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                  hintText: "${hint}",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class CustomViewsValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomViewsValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.ViewsValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeViewsValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomAdsTypeValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomAdsTypeValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.adsTypeValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeadsTypeValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomdropDownStyleTypeValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomdropDownStyleTypeValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.dropDownStyleTypeValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeDropDownStyleTypeValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomfinishTypeValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomfinishTypeValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.finishTypeValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeFinishTypeValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustompurposeValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustompurposeValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.purposeValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changePurposeValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomPaymenyMethodValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomPaymenyMethodValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.paymentMethodValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changePaymentMethodValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomrequiredFieldsValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomrequiredFieldsValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.requiredFieldsValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeRequiredFieldsValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomdescriptionValueSelectList extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomdescriptionValueSelectList({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.descriptionValue,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeDescriptionValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectListAvailable extends StatelessWidget {
  String title = "";
  List<String>? myList = [];

  CustomSelectListAvailable({
    required this.title,
    required this.myList,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: DropdownButton(
                    value: cubit.availabe,
                    underline: SizedBox(),
                    isExpanded: true,
                    hint: Text("Select"),
                    items: myList?.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      cubit.changeAvailableValue(value);
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomGetLocation extends StatelessWidget {
  String title = "";

  CustomGetLocation(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MyMap(),
          ),
        );
      },
      child: Container(
        height: sizeFromHeight(6.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ],
            ),
            Container(
              height: sizeFromHeight(10),
              decoration: BoxDecoration(
                  color: ColorManager.onboardingColorDots,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "PickUp Location",
                      style: TextStyle(
                          color: ColorManager.WhiteScreen, fontSize: 16),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: SvgPicture.asset("assets/images/map.svg"),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSelectBathRoomNumber extends StatelessWidget {
  String title = "";
  int num;

  CustomSelectBathRoomNumber(
    this.title, {
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${num}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeNumBathPlus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronUp,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeNumBathMinus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectFloorNumber extends StatelessWidget {
  String title = "";
  int num;

  CustomSelectFloorNumber(
    this.title, {
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${num}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeNumFloorPlus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronUp,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeNumFloorMinus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectBedRoomNumber extends StatelessWidget {
  String title = "";
  int num;

  CustomSelectBedRoomNumber(
    this.title, {
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${num}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeNumBedRoomsPlus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronUp,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeNumBedRoomsMinus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectRoomNumber extends StatelessWidget {
  String title = "";
  int num;

  CustomSelectRoomNumber(
    this.title, {
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${num}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeNumRoomsPlus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronUp,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeNumRoomsMinus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectNumberOfYear extends StatefulWidget {
  String title = "";
  TextEditingController controller;

  CustomSelectNumberOfYear(this.title, {required this.controller});

  @override
  State<CustomSelectNumberOfYear> createState() =>
      _CustomSelectNumberOfYearState();
}

class _CustomSelectNumberOfYearState extends State<CustomSelectNumberOfYear> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: sizeFromWidth(3),
                            child: TextFormField(
                              controller: widget.controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomSelectDate extends StatefulWidget {
  String title = "";

  CustomSelectDate(
    this.title,
  );

  @override
  State<CustomSelectDate> createState() => _CustomSelectDateState();
}

class _CustomSelectDateState extends State<CustomSelectDate> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return InkWell(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(1990),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              date = newDate;
              widget.title = DateFormat('yyyy-MM-dd').format(newDate);
            });
            cubit.changeDate(DateFormat('yyyy-MM-dd').format(newDate));
          },
          child: Container(
            height: sizeFromHeight(6.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ],
                ),
                Container(
                  height: sizeFromHeight(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorManager.CompareConatainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    child: Center(
                      child: Text("${widget.title}"),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTxtFieldYoutubeAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;

  CustomTxtFieldYoutubeAddUnit(
      {required this.title, required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Center(
              child: TextFormField(
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: "${hint}",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FaIcon(FontAwesomeIcons.link),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSelectListAreas extends StatelessWidget {
  String title = "";
  List<Areas> myList;

  CustomSelectListAreas({
    required this.myList,
    required this.title,
  });

  String? dropDownMenuCities;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommonCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton<Areas>(
              isExpanded: true,
              value: cubit.newAreasValue,
              underline: SizedBox(),
              hint: Text("${title}"),
              items: myList.map((Areas value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                cubit.changeSelectedAreas(value);
                cubit.areaIndex = value?.id;
              },
            ),
          ),
        );
      },
    );
  }
}
