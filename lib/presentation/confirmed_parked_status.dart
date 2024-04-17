import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class ConfirmedParkedStatus extends StatelessWidget {
  const ConfirmedParkedStatus({Key? key})
      : super(
    key: key,
  );

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
            CustomImageView(
              imagePath: ImageConstant.imgCheckmark,
              height: 100.adaptSize,
              width: 100.adaptSize,
            ),
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
            Text(
              "Verify",
              style: CustomTextStyles.titleSmallWhiteA700,
            ),
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
