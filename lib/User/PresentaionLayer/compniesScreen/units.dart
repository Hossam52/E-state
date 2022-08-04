import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/component/search_and_filter_widget.dart';
import 'package:osol/User/BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/companyModel/CompanyModel.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import '../../BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import '../../DataLayer/Model/modelOfData/messageModel/messageModel.dart';
import '../messegeScreen/chatView.dart';
import 'companiesDetails.dart';

class CompaniesListView extends StatelessWidget {
  final CompanyData company;
  CompaniesListView({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return InkWell(
          onTap: () {
            cubit.changeCurrentCompanyId(company.id.toString());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompanyDetailsScreen(
                  companyId: company.id!.toString(),
                ),
              ),
            );
          },
          child: Card(
            color: AppSettingCubit.get(context).isDark
                ? ColorManager.DarkThemeBlackGround2
                : Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 5,
            child: Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: sizeFromHeight(6),
                      width: sizeFromHeight(6),
                      child: cubit.companyData.length == null
                          ? const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                "assets/images/pic3.png",
                              ),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundImage:
                                  NetworkImage(company.image.toString()),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${company.name}",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //         color: Colors.white.withOpacity(0.6),
                            //         borderRadius: BorderRadius.circular(5)),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(5.0),
                            //       child: FaIcon(
                            //         FontAwesomeIcons.solidBookmark,
                            //         color: ColorManager.OnBoardingScreen,
                            //         size: 16,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              OsolIcon.location,
                              color: ColorManager.redHeartcolor,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${company.city} , ${company.country}",
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: sizeFromWidth(2),
                          child: Row(
                            children: [
                              FaIcon(
                                OsolIcon.home,
                                color: Colors.grey[400],
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${company.branchesNum}",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: sizeFromWidth(2),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.tachometerFast,
                                color: Colors.grey[400],
                                size: 14,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "register number ${company.regestrationNum} ",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}

///End Custom Company AppBar
class GridCompanies extends StatelessWidget {
  final CompanyData company;
  GridCompanies({required this.company});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return InkWell(
          onTap: () {
            cubit.changeCurrentCompanyId(company.id.toString());
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => CompanyDetailsScreen(
                  companyId: company.id!.toString(),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.lightBlueAccent, width: 0.5),
                borderRadius: BorderRadius.circular(6)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: cubit.companyData.length == null
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                "assets/images/pic3.png",
                              ),
                            )
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(company.image.toString()),
                            ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${company.name}",
                            style: TextStyle(
                              color: ColorManager.TextHomeColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Icon(
                            OsolIcon.location,
                            color: ColorManager.redHeartcolor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "${company.city} , ${company.country}",
                            style: const TextStyle(fontSize: 9),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: sizeFromWidth(2),
                        child: Row(
                          children: [
                            FaIcon(
                              OsolIcon.home,
                              color: Colors.grey[400],
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${company.branchesNum}",
                              style: TextStyle(
                                  color: ColorManager.TextHomeColor,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        width: sizeFromWidth(2),
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.tachometerFast,
                              color: Colors.grey[400],
                              size: 12,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              " ${company.regestrationNum}",
                              style: TextStyle(
                                  color: ColorManager.TextHomeColor,
                                  fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ],
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

///End Custom Company AppBar

class CustomWriteReviewCompanies extends StatefulWidget {
  @override
  State<CustomWriteReviewCompanies> createState() =>
      _CustomWriteReviewCompaniesState();
}

class _CustomWriteReviewCompaniesState
    extends State<CustomWriteReviewCompanies> {
  TextEditingController addReview = TextEditingController();
  GlobalKey<FormState> AddReviewKey = GlobalKey();
  double? strNum;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return Form(
          key: AddReviewKey,
          child: Container(
            height: sizeFromHeight(3.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: const Text(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      keyboardType: TextInputType.multiline,
                                      validator: (String? v) {
                                        if (v!.isEmpty) {
                                          return "You Must Enter Your Review";
                                        }
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
                                  if (AddReviewKey.currentState!.validate()) {
                                    cubit.zeroId();
                                    cubit.storeReviewAboutCompany(
                                        addReview.text, strNum!);
                                  }
                                },
                                child: Container(
                                  child: FaIcon(
                                    FontAwesomeIcons.telegram,
                                    color: ColorManager.onboardingColorDots,
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
        );
      },
    );
  }
}

///End custom write review
class CustomReviewCompanies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = CompanyCubit.get(context);
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          height: sizeFromHeight(2.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                child: const Text(
                  "Reviews",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: sizeFromHeight(3),
                width: sizeFromWidth(1),
                child: cubit.isReviewsLoading
                    ? const Center(child: const CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.dataOfCompanyReview.length,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: sizeFromHeight(3),
                                    width: sizeFromWidth(1.2),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black87),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: sizeFromHeight(12),
                                                width: sizeFromWidth(8),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            sizeFromHeight(
                                                                20))),
                                                child: Image.network(
                                                  "${cubit.dataOfCompanyReview[index].client?.image}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: sizeFromHeight(13),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "${cubit.dataOfCompanyReview[index].client?.userName}",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${cubit.dataOfCompanyReview[index].date?.substring(0, 10)}",
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  "${index + 1}/${cubit.dataOfCompanyReview.length}"),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: sizeFromHeight(7),
                                            child: Text(
                                              "${cubit.dataOfCompanyReview[index].body}",
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        RatingBarIndicator(
                                          itemSize: 20,
                                          rating: cubit
                                                  .dataOfCompanyReview[index]
                                                  .strNum ??
                                              0,
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  index + 1 == cubit.dataOfCompanyReview.length
                                      ? InkWell(
                                          onTap: cubit.currentReview != null
                                              ? () async {
                                                  await cubit.changeId();
                                                  cubit
                                                      .getReviewsForDetectedCompany();
                                                }
                                              : () {},
                                          child: cubit.currentReview != null
                                              ? const Icon(
                                                  Icons.arrow_forward_ios)
                                              : const Icon(
                                                  Icons.arrow_forward_ios,
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
class CustomAboutDeveloperCompanies extends StatelessWidget {
  String branches;

  CustomAboutDeveloperCompanies({required this.branches});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: sizeFromHeight(19),
        width: sizeFromWidth(1.5),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              const Text(
                "Branches",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Text(
                "$branches branches",
                style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}

///End custom about developer
class CustomDescriptionCompanies extends StatelessWidget {
  String phone;

  CustomDescriptionCompanies({required this.phone});

  List<UserCompany>? companiesMail;

  getDataOfAllCompanies(context) async {
    companiesMail = [];
    debugPrint("sa");
    final messages = await FirebaseFirestore.instance
        .collection("UeserCompany")
        .doc(ProfileCubit.get(context).profileDate[0].client!.email.toString())
        .collection("usersEmail")
        .get();
    for (var message in messages.docs) {
      debugPrint("${message.data()}");
      companiesMail!.add(UserCompany.fromJson(message.data()));
    }
    debugPrint("da");
  }

  sendCompanyToFireStore(
      {required String email,
      required String name,
      required String image,
      required BuildContext context}) {
    FirebaseFirestore.instance
        .collection("UeserCompany")
        .doc(ProfileCubit.get(context).profileDate[0].client!.email.toString())
        .collection("usersEmail")
        .add({
      "userMail": ProfileCubit.get(context).profileDate[0].client!.email,
      "email": email,
      "name": name,
      "image": image,
      "time": FieldValue.serverTimestamp()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          height: sizeFromHeight(9),
          width: sizeFromWidth(1.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatView(
                        image:
                            CompanyCubit.get(context).company!.image.toString(),
                        email:
                            CompanyCubit.get(context).company!.email.toString(),
                        name:
                            CompanyCubit.get(context).company!.name.toString(),
                      ),
                    ),
                  );
                },
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

///End custom description
class CustomdetailsOfCompanies extends StatelessWidget {
  String about;
  String companyType;
  String email;
  String regiserNum;
  String phone;

  CustomdetailsOfCompanies({
    required this.email,
    required this.about,
    required this.companyType,
    required this.regiserNum,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(2),
      width: sizeFromWidth(1.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: sizeFromWidth(2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                  ),
                ),
                Text(
                  "Company type",
                  style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                  ),
                ),
                Text(
                  "Email",
                  style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                  ),
                ),
                Text(
                  "Mobile",
                  style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                  ),
                ),
                Text(
                  "Registeration number",
                  style: TextStyle(
                    color: ColorManager.onboardingColorDots,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: sizeFromWidth(2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: sizeFromWidth(2.5),
                  child: Text(
                    "$about",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                Text(
                  "$companyType",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "$email",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "$phone",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "$regiserNum",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

///End custom unit details of units
class CustomIInformationCompanies extends StatelessWidget {
  String img;
  String companyName;
  String creationDate;

  CustomIInformationCompanies({
    required this.creationDate,
    required this.img,
    required this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              backgroundColor: ColorManager.WhiteScreen,
              backgroundImage: NetworkImage(img),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$companyName",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$creationDate",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          const Spacer(),
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (_) => NotificationScreen()));
          //     },
          //     icon: FaIcon(
          //       FontAwesomeIcons.bell,
          //       color: ColorManager.AppBarIconcolorGrey,
          //     )),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              color: ColorManager.AppBarIconcolorGrey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

///End custom unit information
