import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

// ignore: must_be_immutable
class ChooseparkingoneItemWidget extends StatelessWidget {
  ChooseparkingoneItemWidget({
    Key? key,
    this.onTapTxtSouthallCarPark,
  }) : super(
          key: key,
        );

  VoidCallback? onTapTxtSouthallCarPark;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgOutputOnlinepn,
            height: 40.v,
            width: 25.h,
            margin: EdgeInsets.only(bottom: 9.v),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 22.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      onTapTxtSouthallCarPark!.call();
                    },
                    child: Text(
                      "Southall Car Park",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 4.v),
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
          ),
        ],
      ),
    );
  }
}
