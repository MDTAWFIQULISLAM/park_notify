import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class ChooseParkingFourScreen extends StatelessWidget {
  const ChooseParkingFourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSix(context),
                      SizedBox(height: 30.v),
                      _buildSeventyEight(context),
                      SizedBox(height: 2.v),
                      _buildSeventySix(context),
                      SizedBox(height: 5.v),
                      Padding(
                          padding: EdgeInsets.only(left: 36.h),
                          child: Text("24 hrs, All Week",
                              style: CustomTextStyles.titleLargeOxygenBold_1)),
                      SizedBox(height: 15.v),
                      Padding(
                          padding: EdgeInsets.only(left: 36.h, right: 61.h),
                          child: _buildEightyOne(context,
                              duration: "1 day", price: "£5.00")),
                      SizedBox(height: 3.v),
                      Padding(
                          padding: EdgeInsets.only(left: 36.h, right: 61.h),
                          child: _buildEightyOne(context,
                              duration: "7 days", price: "£10.00")),
                      SizedBox(height: 2.v),
                      Divider(indent: 31.h, endIndent: 50.h),
                      Padding(
                          padding: EdgeInsets.only(left: 38.h),
                          child: Text("Restrictions",
                              style: CustomTextStyles.titleLargeOxygenBold_1)),
                      SizedBox(height: 9.v),
                      Padding(
                          padding: EdgeInsets.only(left: 34.h, right: 82.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 1.v),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Maximum stay",
                                              style: CustomTextStyles
                                                  .titleLargeOxygenBold_1),
                                          SizedBox(height: 2.v),
                                          Text("Permit required",
                                              style: CustomTextStyles
                                                  .titleLargeOxygenBold_1)
                                        ])),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 3.v),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("2 days",
                                              style: CustomTextStyles
                                                  .titleLargeOxygenBold),
                                          Text("No",
                                              style: CustomTextStyles
                                                  .titleLargeOxygenBold)
                                        ]))
                              ])),
                      SizedBox(height: 5.v)
                    ])),
            bottomNavigationBar: _buildSeventyNine(context)));
  }

  /// Section Widget
  Widget _buildSix(BuildContext context) {
    return SizedBox(
        height: 464.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topLeft, children: [
          CustomImageView(
              imagePath: ImageConstant.imgRectangle19464x430,
              height: 464.v,
              width: 430.h,
              radius: BorderRadius.circular(20.h),
              alignment: Alignment.center),
          CustomImageView(
              imagePath: ImageConstant.imgScreenshot2024,
              height: 48.v,
              width: 33.h,
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 42.h, top: 120.v))
        ]));
  }

  /// Section Widget
  Widget _buildSeventyEight(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomImageView(
                      imagePath: ImageConstant.imgScreenshot2024,
                      height: 47.v,
                      width: 28.h,
                      margin: EdgeInsets.only(bottom: 10.v)),
                  Padding(
                      padding: EdgeInsets.only(left: 12.h, top: 5.v),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Southall Car Park",
                                style: theme.textTheme.titleLarge),
                            SizedBox(height: 5.v),
                            RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: "Free · ",
                                      style:
                                          CustomTextStyles.bodyLargeff000000),
                                  TextSpan(
                                      text: "ULEZ",
                                      style:
                                          CustomTextStyles.bodyLargeff0274ba),
                                  TextSpan(
                                      text: " · 1.5 miles",
                                      style: CustomTextStyles.bodyLargeff000000)
                                ]),
                                textAlign: TextAlign.center)
                          ])),
                  Spacer(),
                  CustomImageView(
                      imagePath: ImageConstant.imgScreenshot202433x28,
                      height: 33.v,
                      width: 28.h,
                      margin: EdgeInsets.only(bottom: 24.v))
                ])));
  }

  /// Section Widget
  Widget _buildSeventySix(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: SizedBox(
            height: 45.v,
            width: 349.h,
            child: Stack(alignment: Alignment.centerLeft, children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                      padding: EdgeInsets.only(top: 13.v),
                      child: SizedBox(width: 349.h, child: Divider()))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 2.h, right: 41.h),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(top: 19.v),
                                child: Text("Prices",
                                    style: CustomTextStyles
                                        .titleLargeOxygenBold_1)),
                            Padding(
                                padding: EdgeInsets.only(bottom: 24.v),
                                child: Text("Side of road",
                                    style: CustomTextStyles
                                        .titleMediumOxygenWhiteA700Bold))
                          ])))
            ])));
  }

  /// Section Widget
  Widget _buildSeventyNine(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 33.h, right: 33.h, bottom: 29.v),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: CustomElevatedButton(
                  text: "Return",
                  margin: EdgeInsets.only(right: 20.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL15,
                  onPressed: () {
                    onTapReturn(context);
                  })),
          Expanded(
              child: CustomElevatedButton(
                  text: "Park",
                  margin: EdgeInsets.only(left: 20.h),
                  buttonStyle: CustomButtonStyles.fillOnErrorContainerTL15,
                  onPressed: () {
                    onTapPark(context);
                  }))
        ]));
  }

  /// Common widget
  Widget _buildEightyOne(
    BuildContext context, {
    required String duration,
    required String price,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(duration,
          textAlign: TextAlign.center,
          style: CustomTextStyles.titleLargeOxygenBold_1.copyWith(
              color: theme.colorScheme.onErrorContainer.withOpacity(1))),
      Text(price,
          style: CustomTextStyles.titleLargeOxygenBold_1.copyWith(
              color: theme.colorScheme.onErrorContainer.withOpacity(1)))
    ]);
  }

  /// Navigates to the chooseParkingOneScreen when the action is triggered.
  onTapReturn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chooseParkingOneScreen);
  }

  /// Navigates to the confirmationScreen when the action is triggered.
  onTapPark(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.confirmationScreen);
  }
}
