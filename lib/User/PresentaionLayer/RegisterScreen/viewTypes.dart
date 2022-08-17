import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osol/Company/PresentationLayer/registerition/registeration/view.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';

class TypesScreen extends StatelessWidget {
  const TypesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.OnBoardingScreen,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  color: ColorManager.OnBoardingScreen,
                ),
                height: sizeFromHeight(2),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: sizeFromHeight(1.5),
                  width: sizeFromWidth(1),
                  alignment: Alignment.bottomCenter,
                  child: CircleAvatar(
                    radius: sizeFromWidth(4),
                    child: const Image(
                      image: AssetImage(
                        "assets/images/estateco.png",
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(5),
                  width: sizeFromWidth(1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/images/logoop.svg",
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(1.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(1.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(1.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  height: sizeFromHeight(1.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SizedBox(
              height: sizeFromHeight(3),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => CompanyRegisterationScreen()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: sizeFromHeight(10),
                        decoration: BoxDecoration(
                            color: ColorManager.OnBoardingScreen,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            "Company Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => SignUpView()));
                      },
                      child: Container(
                        width: double.infinity,
                        height: sizeFromHeight(10),
                        decoration: BoxDecoration(
                            color: ColorManager.WhiteScreen,
                            border: Border.all(
                                color: ColorManager.OnBoardingScreen, width: 2),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                          child: Text(
                            "Personal Account",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
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
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9558952, size.height);
    path_0.lineTo(size.width * 0.7747700, size.height);
    path_0.arcToPoint(Offset(size.width * 0.7330158, size.height * 0.9739593),
        radius: Radius.elliptical(
            size.width * 0.04410475, size.height * 0.03846154),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.cubicTo(
        size.width * 0.7265972,
        size.height * 0.8515724,
        size.width * 0.6242457,
        size.height * 0.7557036,
        size.width * 0.5000000,
        size.height * 0.7557036);
    path_0.cubicTo(
        size.width * 0.3757543,
        size.height * 0.7557036,
        size.width * 0.2734157,
        size.height * 0.8515701,
        size.width * 0.2669842,
        size.height * 0.9739502);
    path_0.arcToPoint(Offset(size.width * 0.2252274, size.height),
        radius: Radius.elliptical(
            size.width * 0.04410475, size.height * 0.03846154),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(size.width * 0.04410475, size.height);
    path_0.arcToPoint(Offset(0, size.height * 0.9615385),
        radius: Radius.elliptical(
            size.width * 0.04410475, size.height * 0.03846154),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height * 0.9615385);
    path_0.arcToPoint(Offset(size.width * 0.9558952, size.height),
        radius: Radius.elliptical(
            size.width * 0.04410475, size.height * 0.03846154),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
