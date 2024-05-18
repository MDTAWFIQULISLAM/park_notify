import 'package:flutter/material.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/core/app_export.dart';

class PaymentCompleted extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 202.v),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckmarkLogo(size: 100.adaptSize),
            SizedBox(height: 38.v),
            Text(
              "Payment Completed!",
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: 39.v),
            CustomElevatedButton(
              text: "Set Custom Reminder",
              onPressed: () {
                _onTapSetReminder(context);
              },
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
        color: Colors.green,
        borderRadius: BorderRadius.circular(size / 2),
      ),
      child: Center(
        child: CustomPaint(
          size: Size(size * 0.6, size * 0.6),
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
      ..color = Colors.white
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.1, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.8);
    path.lineTo(size.width * 0.9, size.height * 0.2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

void _onTapSetReminder(BuildContext context) {
  Navigator.pushNamed(context, AppRoutes.setReminderPage);
}
