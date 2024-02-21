import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_phone_number.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('44');

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  bool agreeWithTermsConditions = false;

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
                                horizontal: 34.h, vertical: 53.v),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 1.h),
                                      child: Text("Create an account",
                                          style:
                                          theme.textTheme.headlineSmall)),
                                  SizedBox(height: 2.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 5.h),
                                      child: Text(
                                          "Start avoiding parking tickets now!",
                                          style: theme.textTheme.titleSmall)),
                                  SizedBox(height: 51.v),
                                  _buildNinetyFour(context),
                                  SizedBox(height: 9.v),
                                  _buildPhoneNumber1(context),
                                  SizedBox(height: 15.v),
                                  _buildNinetyEight(context),
                                  SizedBox(height: 19.v),
                                  _buildRememberMe(context),
                                  SizedBox(height: 18.v),
                                  _buildAgreeWithTermsConditions(context),
                                  SizedBox(height: 29.v),
                                  _buildSignupButton(context),
                                  SizedBox(height: 22.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 60.h),
                                      child: Row(children: [
                                        Text("Already have an account?",
                                            style: theme.textTheme.titleSmall),
                                        Padding(
                                            padding: EdgeInsets.only(left: 8.h),
                                            child: Text("Sign in",
                                                style: CustomTextStyles
                                                    .titleSmallPrimaryContainer))
                                      ])),
                                  SizedBox(height: 5.v)
                                ])))))));
  }

  /// Section Widget
  Widget _buildEmail(BuildContext context) {
    return CustomTextFormField(
        controller: emailController,
        hintText: "Enter your email",
        textInputType: TextInputType.emailAddress);
  }

  /// Section Widget
  Widget _buildNinetyFour(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Email​ address", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          _buildEmail(context)
        ]));
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return CustomPhoneNumber(
        country: selectedCountry,
        controller: phoneNumberController,
        onTap: (Country value) {
          selectedCountry = value;
        });
  }

  /// Section Widget
  Widget _buildPhoneNumber1(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Phone number", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          _buildPhoneNumber(context)
        ]));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return CustomTextFormField(
        controller: passwordController,
        hintText: "Please Enter Your Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
            margin: EdgeInsets.fromLTRB(30.h, 12.v, 17.h, 11.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgEyefill,
                height: 18.adaptSize,
                width: 18.adaptSize)),
        suffixConstraints: BoxConstraints(maxHeight: 41.v),
        obscureText: true,
        contentPadding: EdgeInsets.only(left: 13.h, top: 11.v, bottom: 11.v));
  }

  /// Section Widget
  Widget _buildNinetyEight(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Password", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          _buildPassword(context)
        ]));
  }

  /// Section Widget
  Widget _buildRememberMe(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: CustomCheckboxButton(
            text: "Remember Me",
            value: rememberMe,
            padding: EdgeInsets.symmetric(vertical: 1.v),
            onChange: (value) {
              rememberMe = value;
            }));
  }

  /// Section Widget
  Widget _buildAgreeWithTermsConditions(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 1.h),
        child: CustomCheckboxButton(
            text: "Agree with Terms & Conditions",
            value: agreeWithTermsConditions,
            onChange: (value) {
              agreeWithTermsConditions = value;
            }));
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
  Widget _buildContinueWithGoogleButton(BuildContext context) {
    return CustomOutlinedButton(
        text: "Continue with Google",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 14.h),
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

  /// Section Widget
  Widget _buildSignupButton(BuildContext context) {
    return Column(children: [
      _buildContinueButton(context),
      SizedBox(height: 22.v),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
      ]),
      SizedBox(height: 14.v),
      _buildContinueWithGoogleButton(context),
      SizedBox(height: 22.v),
      _buildContinueWithAppleButton(context)
    ]);
  }

  /// Navigates to the registerYourVehicleScreen when the action is triggered.
  onTapContinueButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  /// Navigates to the registerYourVehicleScreen when the action is triggered.
  onTapContinueWithGoogleButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  /// Navigates to the registerYourVehicleScreen when the action is triggered.
  onTapContinueWithAppleButton(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }
}
