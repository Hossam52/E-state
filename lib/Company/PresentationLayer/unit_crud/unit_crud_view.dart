import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/widgets/custom_drop_down.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/widgets/select_images.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:osol/common_models/unit_model.dart';

// import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import './unit_crud_widgets.dart';

class UnitCrudView extends StatefulWidget {
  final UnitModel? unit; //If null that means add unit else means update unit
  final String? adsType;
  const UnitCrudView({Key? key, this.unit, this.adsType}) : super(key: key);

  @override
  State<UnitCrudView> createState() => _UnitCrudViewState();
}

class _UnitCrudViewState extends State<UnitCrudView> {
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

  @override
  void initState() {
    super.initState();
    titleController.text = widget.unit?.title ?? '';
    priceCntroller.text = widget.unit?.price?.toString() ?? '';
    depositController.text = widget.unit?.deposite?.toString() ?? '';
    downPaymentController.text = widget.unit?.downPayment?.toString() ?? '';
    monthlyPaymentController.text =
        widget.unit?.monthlyPayment?.toString() ?? '';
    numberOfYearController.text = widget.unit?.numYears?.toString() ?? '';
    yearBuildController.text = widget.unit?.yearBuild?.toString() ?? '';
    areaController.text = widget.unit?.area?.toString() ?? '';
    videoURLController.text = widget.unit?.video ?? '';
  }

  bool get isUpdateUnit {
    return widget.unit != null;
  }

  navigateFun(context) {
    if (widget.unit != null) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NavigationDrawerCompany()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommonCubit, CommonState>(
      builder: (context, state) {
        if (state is LoadingGetCountry) {
          return const Material(
              child: Center(child: CircularProgressIndicator()));
        }
        if (CommonCubit.get(context).countryModel == null) {
          return Material(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error happened try again',
                    style: Theme.of(context).textTheme.headline3!,
                  ),
                  SizedBox(height: 20.h),
                  TextButton(
                      onPressed: () {
                        CommonCubit.get(context).getCountry();
                      },
                      child: Text('Retry',
                          style: Theme.of(context).textTheme.headline3))
                ],
              ),
            ),
          );
        }
        return BlocProvider(
          create: (context) {
            if (widget.unit == null) {
              return UnitCubit(context)..initAdsType(widget.adsType);
            } else {
              return UnitCubit(context)
                ..initDropDownValues(CommonCubit.get(context), widget.unit!);
            }
          },
          child: BlocConsumer<UnitCubit, UnitState>(
            listener: (context, state) {
              state is SuccesAddingDataState
                  ? navigateFun(context)
                  : debugPrint("Error on Adding the value");
            },
            builder: (context, state) {
              var cubit = UnitCubit.get(context);
              return WillPopScope(
                onWillPop: () async {
                  return navigateFun(context);
                },
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    toolbarHeight: 80,
                    leading: IconButton(
                      onPressed: () {
                        navigateFun(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                    shape: const ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                    ),
                    centerTitle: true,
                    title: Text(
                      isUpdateUnit ? 'Update unit' : "Add Unit",
                    ),
                  ),
                  body: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, bottom: 15, left: 20, right: 20),
                            child: SelectUnitImages()),
                      ),
                      SliverToBoxAdapter(
                        child: DetailsOfContains(
                          area: areaController.text,
                        ),
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
                            maxLength: 20,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                            title: "Uses",
                            list: cubit.requiredFields,
                            onChange: cubit.changeRequiredFieldsValue,
                            selectedItem: cubit.requiredFieldsValue,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                            title: "View",
                            list: cubit.Views,
                            onChange: cubit.changeViewsValue,
                            selectedItem: cubit.ViewsValue,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                              title: "Ads Type",
                              list: cubit.adsType,
                              onChange: widget.adsType != null
                                  ? null
                                  : cubit.changeadsTypeValue,
                              selectedItem: cubit.adsTypeValue),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                            title: "Select Purpose",
                            list: cubit.purpose,
                            onChange: cubit.changePurposeValue,
                            selectedItem: cubit.purposeValue,
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
                                  maxLength: 7,
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
                                        const SizedBox(
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
                                              child:
                                                  CustomTxtFieldCompanyProfile(
                                                controller:
                                                    downPaymentController,
                                                hint: "Down Payment",
                                                title: "Down Payment",
                                                width: sizeFromWidth(2.4),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child:
                                                  CustomTxtFieldCompanyProfile(
                                                controller:
                                                    monthlyPaymentController,
                                                hint:
                                                    "Enter Your Month Payment",
                                                title: "Monthly Payment",
                                                width: sizeFromWidth(2.4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SliverToBoxAdapter(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                              title: "Payment Method",
                              list: cubit.paymentMethod,
                              onChange: cubit.changePaymentMethodValue,
                              selectedItem: cubit.paymentMethodValue),
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
                                    const SizedBox(
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
                          : const SliverToBoxAdapter(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomDropDownList(
                            title: "Style Type",
                            list: cubit.styleType,
                            onChange: cubit.changeadsTypeValue,
                            selectedItem: cubit.dropDownStyleTypeValue,
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
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CustomSelectListRegister(
                                        myList: cubit.countryData,
                                        title: "Country",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CustomSelectListCities(
                                        myList: cubit.cityData,
                                        title: "City",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: AddUnitSelectListAreas(
                                        myList: cubit.areasData,
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
                          padding: const EdgeInsets.symmetric(
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
                              const SizedBox(
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
                              const SizedBox(
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
                              const SizedBox(
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
                                child: CustomDropDownList(
                                  title: "Available",
                                  list: cubit.availableDate,
                                  onChange: cubit.changeAvailableValue,
                                  selectedItem: cubit.availabe,
                                ),
                              ),
                              const SizedBox(
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
                          child: CustomDropDownList(
                            title: "Finish Type",
                            list: cubit.finishType,
                            onChange: cubit.changeFinishTypeValue,
                            selectedItem: cubit.finishTypeValue,
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
                        child: CustomOtherDataAddInCompany(unit: widget.unit),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20),
                          child: Container(
                            height: sizeFromHeight(10),
                            child: state is LoadingAddUnitState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        maximumSize:
                                            const Size(double.infinity, 50)),
                                    onPressed: () async {
                                      state is ChangeImageUnitState
                                          ? await cubit.changeListData()
                                          : print("Error");
                                      // cubit.AddUnit(
                                      //   context: context,
                                      //   add_type: cubit.adsTypeValue,
                                      //   air_condition: cubit.valueAirCondition
                                      //       ? "on"
                                      //       : null,
                                      //   area: areaController.text,
                                      //   area_id: "1",

                                      //   ///available take bool value 0/1
                                      //   available: cubit.availabe == "available"
                                      //       ? 1
                                      //       : 0,
                                      //   available_date: cubit.title,
                                      //   bakary: cubit.BakaryDistance,
                                      //   balcony:
                                      //       cubit.valuebalcony ? "on" : null,
                                      //   bathroom: cubit.numBathRoom,
                                      //   beach: cubit.beachDistance,
                                      //   bedrooms: cubit.numBedRoom,
                                      //   bus: cubit.BusDistance,
                                      //   cable_tv:
                                      //       cubit.valueCableTV ? "on" : null,
                                      //   city_id: CommonCubit.get(context)
                                      //       .cityIndex
                                      //       .toString(),
                                      //   coffe: cubit.coffeDistance,
                                      //   computer:
                                      //       cubit.valueComputer ? "on" : null,
                                      //   country_id: CommonCubit.get(context)
                                      //       .valueCountryId
                                      //       .toString(),
                                      //   deposite: depositController.text,
                                      //   description: "vial",
                                      //   dishwasher:
                                      //       cubit.valueDishwasher ? "on" : null,
                                      //   down_payment:
                                      //       downPaymentController.text,
                                      //   finished_type: cubit.finishTypeValue,
                                      //   floor: cubit.numFloor,
                                      //   gas_line:
                                      //       cubit.valueGasline ? "on" : null,
                                      //   grill: cubit.valueGrill ? "on" : null,
                                      //   heater: cubit.valueHeater ? "on" : null,
                                      //   internet:
                                      //       cubit.valueInternet ? "on" : null,
                                      //   lat: cubit.latitude,
                                      //   lift: cubit.valueLift ? "on" : null,
                                      //   long: cubit.longitude,
                                      //   metro: cubit.metroDistance,
                                      //   microwave:
                                      //       cubit.valueMicrowave ? "on" : null,
                                      //   monthly_payment:
                                      //       monthlyPaymentController.text,
                                      //   num_years: numberOfYearController.text,
                                      //   parking:
                                      //       cubit.valueParking ? "on" : null,
                                      //   payment_method:
                                      //       cubit.paymentMethodValue,
                                      //   pharmacy: cubit.pharmacyDistance,
                                      //   pool: cubit.valuePool ? "on" : null,
                                      //   price: priceCntroller.text,
                                      //   purpose: cubit.purposeValue,
                                      //   recption: null,
                                      //   required_fields:
                                      //       cubit.requiredFieldsValue,
                                      //   resturant: cubit.restDistance,
                                      //   rooms: cubit.numRoom,
                                      //   security: null,
                                      //   title: titleController.text,
                                      //   train: cubit.trainDistance,
                                      //   type: cubit.dropDownStyleTypeValue,
                                      //   video: videoURLController.text,
                                      //   view: cubit.ViewsValue,
                                      //   year_build: yearBuildController.text,
                                      // );
                                      if (isUpdateUnit) {
                                        await updateUnit(context);
                                      } else {
                                        await addNewUnit(context);
                                      }
                                    },
                                    child: Text(
                                      isUpdateUnit ? 'Update' : "Publish",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> addNewUnit(BuildContext context) async {
    await UnitCubit.get(context).addUnit(
      context: context,
      area: areaController.text,
      deposite: depositController.text,
      downPayment: downPaymentController.text,
      monthlyPayment: monthlyPaymentController.text,
      numYears: numberOfYearController.text,
      price: priceCntroller.text,
      title: titleController.text,
      video: videoURLController.text,
      yearBuild: yearBuildController.text,
    );
  }

  Future<void> updateUnit(BuildContext context) async {
    await UnitCubit.get(context).updateUnit(
      unitId: widget.unit!.id!.toString(),
      context: context,
      area: areaController.text,
      deposite: depositController.text,
      downPayment: downPaymentController.text,
      monthlyPayment: monthlyPaymentController.text,
      numYears: numberOfYearController.text,
      price: priceCntroller.text,
      title: titleController.text,
      video: videoURLController.text,
      yearBuild: yearBuildController.text,
    );
  }
}

///Screen

///

/*
  images
  mainTitle
  uses
  view
  adsType
  purpose
  payment
  styleType
  location
  country - city - areas
  rooms   bathrooms
  floor year_build
  area bedrooms
  available date
  finishtype
  youtube
  other
 */