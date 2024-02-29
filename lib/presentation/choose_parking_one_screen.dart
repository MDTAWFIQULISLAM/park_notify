import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/chooseparkingone_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class ChooseParkingOneScreen extends StatelessWidget {
  const ChooseParkingOneScreen({Key? key}) : super(key: key);

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
                      child: Stack(alignment: Alignment.topLeft, children: [
                        CustomImageView(
                            imagePath: ImageConstant.imgRectangle19,
                            height: 510.v,
                            width: 430.h,
                            radius: BorderRadius.circular(20.h),
                            alignment: Alignment.center),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    100.h, 142.v, 189.h, 296.v),
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgOutputOnlinepn,
                                          height: 48.v,
                                          width: 30.h,
                                          margin: EdgeInsets.only(top: 24.v)),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgOutputOnlinepn,
                                          height: 48.v,
                                          width: 30.h,
                                          margin: EdgeInsets.only(
                                              left: 19.h, bottom: 24.v)),
                                      Spacer(),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgOutputOnlinepn,
                                          height: 48.v,
                                          width: 30.h,
                                          margin: EdgeInsets.only(bottom: 24.v))
                                    ])))
                      ])),
                  SizedBox(height: 28.v),
                  _buildSeventy(context),
                  SizedBox(height: 27.v),
                  _buildChooseParkingOne(context)
                ]))));
  }

  /// Section Widget
  Widget _buildSeventy(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 28.h, right: 38.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: CustomElevatedButton(
                  text: "Car Park",
                  margin: EdgeInsets.only(right: 20.h),
                  buttonStyle: CustomButtonStyles.fillOnErrorContainerTL15)),
          Expanded(
              child: CustomElevatedButton(
                  text: "Side of road",
                  margin: EdgeInsets.only(left: 20.h),
                  buttonStyle: CustomButtonStyles.fillPrimaryTL15,
                  onPressed: () {
                    onTapSideOfRoad(context);
                  }))
        ]));
  }

  /// Section Widget
  Widget _buildChooseParkingOne(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: EdgeInsets.only(left: 21.h, right: 45.h),
            child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.5.v),
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
                  return ChooseparkingoneItemWidget(
                      onTapTxtSouthallCarPark: () {
                    onTapTxtSouthallCarPark(context);
                  });
                })));
  }

  /// Navigates to the chooseParkingTwoScreen when the action is triggered.
  onTapSideOfRoad(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chooseParkingTwoScreen);
  }

  /// Navigates to the chooseParkingFourScreen when the action is triggered.
  onTapTxtSouthallCarPark(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.chooseParkingFourScreen);
  }
}
