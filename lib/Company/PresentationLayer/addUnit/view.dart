import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';

// import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import './widgets/add_unit_widgets.dart';

class AddUnitInCompanyScreen extends StatefulWidget {
  @override
  State<AddUnitInCompanyScreen> createState() => _AddUnitInCompanyScreenState();
}

class _AddUnitInCompanyScreenState extends State<AddUnitInCompanyScreen> {
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => NavigationDrawerCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitCubit(),
      child: BlocConsumer<UnitCubit, UnitState>(
        listener: (context, state) {
          state is SuccesAddingDataState
              ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => NavigationDrawerCompany()))
              : debugPrint("Error on Adding the value");
        },
        builder: (context, state) {
          var cubit = UnitCubit.get(context);
          // imageFileList!.isNotEmpty
          //     ? cubit.changeImageData(imageFile: imageFileList)
          //     : null;
          //
          // cubit.imageData!.isNotEmpty ? cubit.changeListData() : null;
          //
          // state is ChangeDateState ? print("mostafa date${cubit.title}") : null;

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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            NavigationDrawerCompany()));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 28,
                  ),
                ),
                shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                centerTitle: true,
                title: const Text(
                  "Add Unit",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 20, right: 20),
                        child: _UnitImages()),
                  ),
                  const SliverToBoxAdapter(
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
                        maxLength: 20,
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
                                          child: CustomTxtFieldCompanyProfile(
                                            controller: downPaymentController,
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
                                          child: CustomTxtFieldCompanyProfile(
                                            controller:
                                                monthlyPaymentController,
                                            hint: "Enter Your Month Payment",
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                            child: CustomSelectListAvailable(
                              title: "Available",
                              myList: cubit.availableDate,
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
                        child: state is LoadingAddUnitState
                            ? const Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    maximumSize:
                                        const Size(double.infinity, 50)),
                                onPressed: () async {
                                  state is ChangeImageUnitState
                                      ? await cubit.changeListData()
                                      : print("Error");
                                  cubit.AddUnit(
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
                                    down_payment: downPaymentController.text,
                                    finished_type: cubit.finishTypeValue,
                                    floor: cubit.numFloor,
                                    gas_line: cubit.valueGasline ? "on" : null,
                                    grill: cubit.valueGrill ? "on" : null,
                                    heater: cubit.valueHeater ? "on" : null,
                                    internet: cubit.valueInternet ? "on" : null,
                                    lat: cubit.latitude,
                                    lift: cubit.valueLift ? "on" : null,
                                    long: cubit.longitude,
                                    metro: cubit.metroDistance,
                                    microwave:
                                        cubit.valueMicrowave ? "on" : null,
                                    monthly_payment:
                                        monthlyPaymentController.text,
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
                                },
                                child: const Text(
                                  "Publish",
                                  style: TextStyle(
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
  }
}

///Screen

///

class _UnitImages extends StatefulWidget {
  _UnitImages({Key? key}) : super(key: key);

  @override
  State<_UnitImages> createState() => _UnitImagesState();
}

class _UnitImagesState extends State<_UnitImages> {
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
      changeImageData();
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

  changeImageData() {
    imageFileList!.isNotEmpty
        ? UnitCubit.get(this.context).changeImageData(imageFile: imageFileList)
        : null;

    UnitCubit.get(this.context).imageData!.isNotEmpty
        ? UnitCubit.get(this.context).changeListData()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ImagePick(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        height: sizeFromHeight(2),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: imageFileList!.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: imageFileList?.length ?? 0,
                        itemBuilder: (_, index, __) => Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.fill,
                        ),
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration: Duration(seconds: 1),
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            height: double.infinity),
                      )
                    : SvgPicture.asset("assets/images/imageunit.svg")),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.add,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
