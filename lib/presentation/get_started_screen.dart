import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: theme.colorScheme.primaryContainer,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              ImageConstant.imgGetStartedScreen,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Container(
            width: SizeUtils.width,
            height: SizeUtils.height,
            decoration: BoxDecoration(
              color: Colors.transparent, // Making the container transparent
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Spacer(),
                _buildGetStartedSection(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildGetStartedSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 45.v),
      decoration: AppDecoration.gradientWhiteAToPrimaryContainer,
      child: Column(
        children: [
          SizedBox(height: 109.v),
          Text("No more Parking Tickets", style: theme.textTheme.headlineLarge),
          SizedBox(height: 48.v),
          CustomElevatedButton(
            text: "Get Started",
            buttonStyle: CustomButtonStyles.fillOnError,
            buttonTextStyle: theme.textTheme.titleLarge!,
            onPressed: () {
              onTapGetStarted(context);
            },
          ),
        ],
      ),
    );
  }

  /// Navigates to the loginTwoScreen when the action is triggered.
  onTapGetStarted(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginTwoScreen);
  }
}
