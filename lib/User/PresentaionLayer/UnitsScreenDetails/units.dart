import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/unit_facilities.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/showMapView.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:readmore/readmore.dart';
import '../../BussinssLogic/unitCubit/unit_cubit.dart';
import '../../DataLayer/Model/modelOfData/unitClientModel/getAllReviewData.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DetailsLocatioAndNameUnits extends StatelessWidget {
  String location;
  String bathRoom;
  String bedRoom;
  String area;
  String price;
  String country;
  String city;
  String lat;
  String long;

  DetailsLocatioAndNameUnits(
      {required this.price,
      required this.city,
      required this.area,
      required this.country,
      required this.bathRoom,
      required this.bedRoom,
      required this.location,
      required this.lat,
      required this.long});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: SizedBox(
        height: sizeFromHeight(6),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.bath,
                          color: Colors.grey,
                          size: 12,
                        ),
                        Text(bathRoom),
                        const SizedBox(
                          width: 5,
                        ),
                        const FaIcon(
                          FontAwesomeIcons.bed,
                          size: 12,
                          color: Colors.grey,
                        ),
                        Text(bedRoom),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          OsolIcon.square_,
                          size: 12,
                          color: Colors.grey,
                        ),
                        Text("$area m²"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$price EGP",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        FaIcon(
                          OsolIcon.location,
                          color: ColorManager.redHeartcolor,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "$city, $country",
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorManager.onboardingColorDots),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => MyShowMap(
                                lat: lat,
                                long: long,
                              )));
                    },
                    child: Row(
                      children: const [
                        Icon(
                          OsolIcon.location,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Show On Map",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

///End DetailsLocatioAndNameUnits
class CustomFloatingIcon extends StatelessWidget {
  String? phone;
  CustomFloatingIcon({required this.phone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          height: sizeFromHeight(9),
          width: sizeFromWidth(1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(80)),
                  child: const Icon(
                    Icons.chat_bubble,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FlutterLaunch.launchWhatsapp(
                      phone: "0$phone", message: "Hello");
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(80)),
                  child: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  UrlLauncher.launch('tel:+${phone.toString()}');
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(80)),
                  child: const Icon(
                    Icons.phone,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///End custom Floating Icon
class CustomWriteReview extends StatefulWidget {
  TextEditingController controller;
  void Function()? onTap;

  CustomWriteReview({required this.controller, required this.onTap});

  @override
  State<CustomWriteReview> createState() => _CustomWriteReviewState();
}

class _CustomWriteReviewState extends State<CustomWriteReview> {
  TextEditingController addReview = TextEditingController();

  GlobalKey<FormState> AddReviewKey = GlobalKey();

  double? strNum;

  @override
  Widget build(BuildContext context) {
    var cubit = UnitClientCubit.get(context);
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          height: sizeFromHeight(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Form(
                  key: AddReviewKey,
                  child: SizedBox(
                    height: sizeFromHeight(3.5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Write A review",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        height: sizeFromHeight(6),
                                        width: sizeFromWidth(1.37),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey, width: 2),
                                            color: ColorManager.WhiteScreen,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            )),
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: addReview,
                                              onChanged: (String s) {},
                                              cursorColor: Colors.grey[500],
                                              cursorHeight: sizeFromHeight(17),
                                              minLines: 1,
                                              maxLines: 2,
                                              // allow user to enter 5 line in textfield
                                              keyboardType:
                                                  TextInputType.multiline,
                                              validator: (String? v) {
                                                if (v!.isEmpty) {
                                                  return "You Must Enter Your Review";
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                  bottom: 15,
                                                  left: 10,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            RatingBar.builder(
                                              itemSize: 20,
                                              initialRating: 0,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding: const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                              itemBuilder: (context, _) => const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                setState(() {
                                                  strNum = rating;
                                                });
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: InkWell(
                                        onTap: () {
                                          if (AddReviewKey.currentState!
                                              .validate()) {
                                            cubit.addUnitReview(
                                                reviewBody: addReview.text,
                                                starNum: strNum ?? 0);
                                            cubit.unitAllReviewList.clear();
                                            cubit.getAllUnitReview();
                                          }
                                        },
                                        child: Container(
                                          child: FaIcon(
                                            FontAwesomeIcons.telegram,
                                            color: ColorManager
                                                .onboardingColorDots,
                                            size: 50,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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

///End custom write review
class CustomReview extends StatelessWidget {
  List<DataAllReview> review;

  CustomReview({
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = UnitClientCubit.get(context);
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SizedBox(
          height: sizeFromHeight(2.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Reviews",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: sizeFromHeight(3),
                width: sizeFromWidth(1),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: review.length,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            children: [
                              Container(
                                height: sizeFromHeight(3.1),
                                width: sizeFromWidth(1.3),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black87),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              height: sizeFromHeight(12),
                                              width: sizeFromWidth(8),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          sizeFromHeight(20))),
                                              child: Image.network(
                                                  "${review[index].client?.image}")),
                                        ),
                                        SizedBox(
                                          height: sizeFromHeight(13),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${review[index].client?.userName}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text(
                                                "${review[index].date?.substring(0, 10)}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "${index + 1}/${cubit.totalUnitReview}"),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        height: sizeFromHeight(7),
                                        child: Text(
                                          "${review[index].body}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    RatingBarIndicator(
                                      itemSize: 20,
                                      rating: review[index].strNum!.toDouble(),
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemPadding:
                                          const EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              index + 1 == review.length
                                  ? InkWell(
                                      onTap: cubit.nextPage != null
                                          ? () async {
                                              await cubit.changeId();
                                              cubit.getAllUnitReview();
                                            }
                                          : () {},
                                      child: cubit.nextPage != null
                                          ? const Icon(Icons.arrow_forward_ios)
                                          : const Icon(Icons.arrow_forward_ios,
                                              color: Colors.grey),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        )),
              )
            ],
          ),
        );
      },
    );
  }
}

///End custom review
class CustomVideo extends StatelessWidget {
  const CustomVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Video",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: sizeFromHeight(4),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/images/videos.svg",
              ),
            ),
          )
        ],
      ),
    );
  }
}

///End custom video
class CustomAboutDeveloper extends StatelessWidget {
  const CustomAboutDeveloper({required this.unit});
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: SizedBox(
        height: sizeFromHeight(1.2),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                "About Developer",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: sizeFromHeight(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: ColorManager.onboardingColorDots)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: sizeFromHeight(9),
                      width: sizeFromWidth(6),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/images/deve.svg",
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.onboardingColorDots,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Real estate Company",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            FaIcon(
                              OsolIcon.location,
                              color: ColorManager.redHeartcolor,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "North Coast, Egypt",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Other Data",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            UnitFacilities(
              unit: unit,
            )
          ],
        ),
      ),
    );
  }
}

///End custom about developer
class CustomDescription extends StatelessWidget {
  String description;

  CustomDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: sizeFromHeight(7),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                  color: ColorManager.onboardingColorDots, fontSize: 18),
            ),
            ReadMoreText(
              description,
              style: const TextStyle(fontSize: 16),
              trimLines: 2,
              colorClickableText: ColorManager.onboardingColorDots,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: "Read less",
              moreStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///End custom description
class CustomUnitdetailsOfUnits extends StatelessWidget {
  String status;
  String rooms;
  String floor;
  String bathRooms;
  String yearBuild;
  String finishType;
  String area;
  String view;
  String seller;
  String paymentMethod;

  CustomUnitdetailsOfUnits(
      {required this.area,
      required this.bathRooms,
      required this.finishType,
      required this.floor,
      required this.paymentMethod,
      required this.rooms,
      required this.seller,
      required this.status,
      required this.view,
      required this.yearBuild});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(2),
      width: sizeFromWidth(1.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Rooms",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Floor",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Baths",
                style: TextStyle(
                  color: ColorManager.onboardingColorDots,
                  fontSize: 18,
                ),
              ),
              Text(
                "Year-build",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Finish-type",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Area",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "View",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Seller",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Payment method",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                rooms,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                floor,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                bathRooms,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                yearBuild,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                finishType,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                "$area m²",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                view,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: sizeFromWidth(3),
              ),
              Text(
                seller,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                width: sizeFromWidth(3),
              ),
              Text(
                paymentMethod,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

///End custom unit details of units
class CustomUnitIInformation extends StatelessWidget {
  ImageProvider backgroundImage;
  String unitName;
  String date;

  CustomUnitIInformation({
    required this.backgroundImage,
    required this.date,
    required this.unitName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(7),
      width: 327.w,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  sizeFromWidth(11),
                ),
                border: Border.all(color: ColorManager.onboardingColorDots)),
            child: CircleAvatar(
              radius: sizeFromWidth(12),
              backgroundColor: Colors.transparent,
              backgroundImage: backgroundImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    unitName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    date,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

///End custom unit information
