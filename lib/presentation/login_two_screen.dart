import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginTwoScreen extends StatelessWidget {
  LoginTwoScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: Container(
                            width: double.maxFinite,
                            padding: EdgeInsets.symmetric(
                                horizontal: 34.h, vertical: 55.v),
                            child: Column(children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 3.h),
                                      child: Text("Sign in",
                                          style:
                                          theme.textTheme.headlineSmall))),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text(
                                          "Start avoiding parking tickets now!",
                                          style: theme.textTheme.titleSmall))),
                              SizedBox(height: 76.v),
                              _buildPhoneNumber(context),
                              SizedBox(height: 40.v),
                              _buildContinueButton(context),
                              SizedBox(height: 22.v),
                              _buildWithRow(context),
                              SizedBox(height: 14.v),
                              _buildContinueWithGoogleButton(context),
                              SizedBox(height: 22.v),
                              _buildContinueWithAppleButton(context),
                              SizedBox(height: 21.v),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 1.v),
                                        child: Text("Need an account?",
                                            style: theme.textTheme.titleSmall)),
                                    GestureDetector(
                                        onTap: () {
                                          onTapTxtSignUp(context);
                                        },
                                        child: Padding(
                                            padding: EdgeInsets.only(left: 6.h),
                                            child: Text("Sign up",
                                                style: CustomTextStyles
                                                    .titleSmallPrimaryContainer)))
                                  ]),
                              SizedBox(height: 5.v)
                            ])))))));
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
        controller: phoneNumberController,
        hintText: "Enter your  email address or  phone number",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
        text: "Continue",
        onPressed: () {
          onTapContinueButton(context);
        });
  }

  /// Section Widget
  Widget _buildWithRow(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 9.v, bottom: 8.v),
          child: SizedBox(width: 135.h, child: Divider())),
      Text("Or", style: CustomTextStyles.titleSmallOnPrimary_1),
      Container(
          height: 1.v,
          width: 170.h,
          margin: EdgeInsets.symmetric(vertical: 8.v),
          child: Stack(alignment: Alignment.center, children: [
            Align(
                alignment: Alignment.center,
                child: SizedBox(width: 170.h, child: Divider())),
            Align(
                alignment: Alignment.center,
                child: SizedBox(width: 170.h, child: Divider()))
          ]))
    ]);
  }

  /// Section Widget
  Widget _buildContinueWithGoogleButton(BuildContext context) {
    return CustomOutlinedButton(
        text: "Continue with Google",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 11.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgGoogle,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        onPressed: () {
          onTapContinueWithGoogleButton(context);
        });
  }

  /// Section Widget
  Widget _buildContinueWithAppleButton(BuildContext context) {
    return CustomOutlinedButton(
        text: "     Continue with Apple",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 4.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgImage1, height: 37.v, width: 30.h)),
        buttonStyle: CustomButtonStyles.outlinePrimaryTL10,
        buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
        onPressed: () {
          onTapContinueWithAppleButton(context);
        });
  }

  /// Navigates to the passwordScreen when the action is triggered.
  onTapContinueButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.passwordScreen);
  }

  /// Navigates to the registerYourVehicleScreen when the action is triggered.
  onTapContinueWithGoogleButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  /// Navigates to the registerYourVehicleScreen when the action is triggered.
  onTapContinueWithAppleButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  /// Navigates to the createAccountScreen when the action is triggered.
  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.createAccountScreen);
  }
}
