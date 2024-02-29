import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

// ignore: must_be_immutable
class ChooseparkingtwoItemWidget extends StatelessWidget {
  const ChooseparkingtwoItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle30,
            height: 40.v,
            width: 25.h,
            radius: BorderRadius.circular(
              12.h,
            ),
            margin: EdgeInsets.only(bottom: 23.v),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.h,
              top: 2.v,
              bottom: 13.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 1.h),
                  child: Text(
                    "Blyers road",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 2.v),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Free · ",
                        style: theme.textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: "ULEZ",
                        style: CustomTextStyles.titleMediumff0274ba,
                      ),
                      TextSpan(
                        text: " · 1.5 miles",
                        style: theme.textTheme.titleMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
