import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: theme.colorScheme.primary,
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgGetStartedScreen),
                        fit: BoxFit.cover)),
                child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [Spacer(), _buildThirteen(context)])))));
  }

  /// Section Widget
  Widget _buildThirteen(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 45.v),
        decoration: AppDecoration.gradientWhiteAToPrimary,
        child: Column(children: [
          SizedBox(height: 109.v),
          Text("No more Parking Tickets", style: theme.textTheme.headlineLarge),
          SizedBox(height: 48.v),
          CustomElevatedButton(
              text: "Get Started",
              buttonStyle: CustomButtonStyles.fillOnErrorContainer,
              buttonTextStyle: CustomTextStyles.titleLargeOxygenWhiteA700,
              onPressed: () {
                onTapGetStarted(context);
              })
        ]));
  }

  /// Navigates to the loginTwoScreen when the action is triggered.
  onTapGetStarted(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginTwoScreen);
  }
}
