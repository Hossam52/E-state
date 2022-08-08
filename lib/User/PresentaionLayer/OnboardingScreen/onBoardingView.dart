import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';
import 'package:osol/shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardingData> onbordingData = [
    OnboardingData(
        image: "assets/images/onb1.png",
        Text:
            "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore"),
    OnboardingData(
        image: "assets/images/onb2.png",
        Text:
            "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore"),
    OnboardingData(
        image: "assets/images/onb3.png",
        Text:
            "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore")
  ];

  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Container(
            height: 220.h,
            child: PageView.builder(
              controller: controller,
              physics: BouncingScrollPhysics(),
              itemCount: onbordingData.length,
              itemBuilder: (context, index) {
                currentIndex = index;
                return Column(
                  children: [
                    Expanded(
                      child: Image(
                        image: AssetImage(
                          onbordingData[index].image,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(10.h),
                height: 100.h,
                child: Text(
                  onbordingData[0].Text,
                  style: TextStyle(
                    color: ColorManager.blackFontStyle,
                    fontFamily: "arial",
                    height: 2,
                    fontSize: 20.h,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: sizeFromHeight(5), right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => NavigationDrawer(
                                  token: "",
                                ))),
                    child: Text(
                      "SKIP",
                      style: TextStyle(
                        color: ColorManager.blackFontStyle,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                SmoothPageIndicator(
                  controller: controller,
                  count: onbordingData.length,
                  effect: WormEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: ColorManager.onboardingColorDots,
                    dotColor: ColorManager.onboardingColorDotsNotActive,
                    type: WormType.thin,
                    // strokeWidth: 5,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        print(currentIndex);
                        onbordingData.length == (currentIndex + 1)
                            ? Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                    builder: (_) => NavigationDrawer(
                                          token: "",
                                        )))
                            : controller.nextPage(
                                curve: Curves.linear,
                                duration: Duration(milliseconds: 500));
                      });
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                        color: ColorManager.blackFontStyle,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
