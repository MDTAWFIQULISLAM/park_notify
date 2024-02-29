import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/chooseparkingtwo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class ChooseParkingTwoScreen extends StatelessWidget {
  const ChooseParkingTwoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(children: [
                  SizedBox(
                      height: 510.v,
                      width: double.maxFinite,
                      child: Stack(alignment: Alignment.center, children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 4.h, top: 12.v, right: 223.h),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgRectangle22,
                                                height: 60.v,
                                                width: 42.h,
                                                radius:
                                                    BorderRadius.circular(21.h),
                                                margin: EdgeInsets.only(
                                                    top: 30.v, bottom: 18.v)),
                                            CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgRectangle20,
                                                height: 48.v,
                                                width: 31.h,
                                                radius:
                                                    BorderRadius.circular(15.h),
                                                margin: EdgeInsets.only(
                                                    left: 15.h, bottom: 60.v)),
                                            CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgRectangle20,
                                                height: 48.v,
                                                width: 31.h,
                                                radius:
                                                    BorderRadius.circular(15.h),
                                                margin: EdgeInsets.only(
                                                    left: 25.h,
                                                    top: 24.v,
                                                    bottom: 36.v)),
                                            CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgRectangle20,
                                                height: 48.v,
                                                width: 31.h,
                                                radius:
                                                    BorderRadius.circular(15.h),
                                                margin: EdgeInsets.only(
                                                    left: 28.h, top: 60.v))
                                          ]),
                                      SizedBox(height: 46.v),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgRectangle20,
                                          height: 48.v,
                                          width: 31.h,
                                          radius: BorderRadius.circular(15.h),
                                          margin: EdgeInsets.only(left: 14.h))
                                    ]))),
                        CustomImageView(
                            imagePath: ImageConstant.imgRectangle19,
                            height: 510.v,
                            width: 430.h,
                            radius: BorderRadius.circular(20.h),
                            alignment: Alignment.center)
                      ])),
                  SizedBox(height: 28.v),
                  _buildSixtySix(context),
                  SizedBox(height: 27.v),
                  _buildChooseParkingTwo(context)
                ]))));
  }

  /// Section Widget
  Widget _buildSixtySix(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 33.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: CustomElevatedButton(
                  text: "Car Park",
                  margin: EdgeInsets.only(right: 20.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL15,
                  onPressed: () {
                    onTapCarPark(context);
                  })),
          Expanded(
              child: CustomElevatedButton(
                  text: "Side of road",
                  margin: EdgeInsets.only(left: 20.h),
                  buttonStyle: CustomButtonStyles.fillOnErrorContainerTL15))
        ]));
  }

  /// Section Widget
  Widget _buildChooseParkingTwo(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 28.h, right: 45.h),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.5.v),
                      child: SizedBox(
                          width: 349.h,
                          child: Divider(
                              height: 1.v,
                              thickness: 1.v,
                              color: theme.colorScheme.onErrorContainer
                                  .withOpacity(1))));
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ChooseparkingtwoItemWidget();
                })));
  }

  /// Navigates to the chooseParkingOneScreen when the action is triggered.
  onTapCarPark(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chooseParkingOneScreen);
  }
}
