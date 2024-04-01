import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class VoucherClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    final w = size.width;
    final h = size.height;

    const circlePosition = dimen96;
    const circleWidth = dimen20;
    const salt = dimen1;

    path.lineTo(0, h);
    path.lineTo(circlePosition - circleWidth / 2, h);
    path.cubicTo(
      circlePosition - circleWidth / 2,
      size.height - circleWidth / 2 - salt,
      circlePosition + circleWidth / 2,
      size.height - circleWidth / 2 - salt,
      circlePosition + circleWidth / 2,
      size.height,
    );

    path.lineTo(w, h);
    path.lineTo(w, 0);

    path.lineTo(circlePosition + circleWidth / 2, 0);
    path.cubicTo(
      circlePosition + circleWidth / 2,
      circleWidth / 2 + salt,
      circlePosition - circleWidth / 2,
      circleWidth / 2 + salt,
      circlePosition - circleWidth / 2,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DottedBorderPainter extends CustomPainter {
  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    for (double i = -300; i < 300; i = i + 15) {
      // 15 is space between dots
      if (i % 3 == 0) {
        canvas.drawLine(Offset(0.0, i), Offset(0, i + 10), _paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
