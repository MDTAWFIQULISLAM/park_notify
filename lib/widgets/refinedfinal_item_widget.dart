import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

// ignore: must_be_immutable
class RefinedfinalItemWidget extends StatelessWidget {
  const RefinedfinalItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgScreenshot2024,
          height: 40.v,
          width: 28.h,
          margin: EdgeInsets.only(bottom: 22.v),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 27.h,
            bottom: 11.v,
          ),
          child: Column(
            children: [
              Text(
                "Southall Car Park",
                style: CustomTextStyles.titleLargeOxygen,
              ),
              SizedBox(height: 3.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Free · ",
                      style: CustomTextStyles.bodyLargeOxygenff000000,
                    ),
                    TextSpan(
                      text: "ULEZ",
                      style: CustomTextStyles.bodyLargeOxygenff0274ba,
                    ),
                    TextSpan(
                      text: " · 1.5 miles",
                      style: CustomTextStyles.bodyLargeOxygenff000000,
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
