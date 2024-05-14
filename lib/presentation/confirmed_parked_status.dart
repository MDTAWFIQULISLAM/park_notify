import 'package:flutter/material.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/core/app_export.dart';

class ConfirmedParkedStatus extends StatelessWidget {
  const ConfirmedParkedStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(
          left: 35.h,
          top: 202.v,
          right: 35.h,
        ),
        child: Column(
          children: [
            // CheckmarkLogo widget instead of the CustomImageView
            CheckmarkLogo(size: 100.adaptSize), // Assuming you're using some kind of extension method for responsiveness
            SizedBox(height: 38.v),
            Text(
              "Parking Selected!",
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: 3.v),
            SizedBox(
              width: 209.h,
              child: Text(
                "You have successfully chosen your parking",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: CustomTextStyles.titleSmallBluegray400.copyWith(
                  height: 1.50,
                ),
              ),
            ),
            // Other widgets like 'Verify' text and 'Pay Now' button
            // ...
            SizedBox(height: 39.v),
            CustomElevatedButton(
              text: "Pay Now",
              buttonTextStyle: CustomTextStyles.titleMediumOxygenWhiteA700,
            ),
            SizedBox(height: 5.v),
          ],
        ),
      ),
    );
  }
}

class CheckmarkLogo extends StatelessWidget {
  final double size;

  const CheckmarkLogo({Key? key, this.size = 100.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green, // The green background color
        borderRadius: BorderRadius.circular(size / 2), // Makes it perfectly circular
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.6, size * 0.6), // The checkmark size is a bit smaller than the green box
          painter: _CheckmarkPainter(),
        ),
      ),
    );
  }
}

class _CheckmarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white // The color of the checkmark
      ..strokeWidth = 10 // The thickness of the check mark
      ..strokeCap = StrokeCap.round // The stroke cap for the checkmark
      ..style = PaintingStyle.stroke; // This makes it an outline.

    final path = Path();
    // Start of the checkmark
    path.moveTo(size.width * 0.1, size.height * 0.5);
    // The middle point of the checkmark
    path.lineTo(size.width * 0.4, size.height * 0.8);
    // The end point of the checkmark
    path.lineTo(size.width * 0.9, size.height * 0.2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}