import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

// ignore: must_be_immutable
class EnterdestinationmaimunaItemWidget extends StatelessWidget {
  const EnterdestinationmaimunaItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgScreenshot202446x48,
          height: 46.v,
          width: 48.h,
          margin: EdgeInsets.only(bottom: 12.v),
        ),
        Container(
          height: 44.v,
          width: 261.h,
          margin: EdgeInsets.only(
            left: 15.h,
            top: 5.v,
            bottom: 8.v,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "60 Grove End Rd, London NW8 9NH",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "St John’s Hospital",
                  style: theme.textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
