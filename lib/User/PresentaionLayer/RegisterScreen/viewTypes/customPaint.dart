import 'dart:ui' as ui;

import 'dart:ui';

import 'package:flutter/cupertino.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.9558952,size.height);
    path_0.lineTo(size.width*0.7747700,size.height);
    path_0.arcToPoint(Offset(size.width*0.7330158,size.height*0.9739593),radius: Radius.elliptical(size.width*0.04410475, size.height*0.03846154),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.cubicTo(size.width*0.7265972,size.height*0.8515724,size.width*0.6242457,size.height*0.7557036,size.width*0.5000000,size.height*0.7557036);
    path_0.cubicTo(size.width*0.3757543,size.height*0.7557036,size.width*0.2734157,size.height*0.8515701,size.width*0.2669842,size.height*0.9739502);
    path_0.arcToPoint(Offset(size.width*0.2252274,size.height),radius: Radius.elliptical(size.width*0.04410475, size.height*0.03846154),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(size.width*0.04410475,size.height);
    path_0.arcToPoint(Offset(0,size.height*0.9615385),radius: Radius.elliptical(size.width*0.04410475, size.height*0.03846154),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.lineTo(0,0);
    path_0.lineTo(size.width,0);
    path_0.lineTo(size.width,size.height*0.9615385);
    path_0.arcToPoint(Offset(size.width*0.9558952,size.height),radius: Radius.elliptical(size.width*0.04410475, size.height*0.03846154),rotation: 0 ,largeArc: false,clockwise: true);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color = Color(0xff006aff).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}