import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class LoginTwoScreen extends StatelessWidget {
  LoginTwoScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: SizeUtils.width,
          padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 55.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sign in", style: theme.textTheme.headlineSmall),
              SizedBox(height: 5.v),
              Text("Start avoiding parking tickets now!", style: theme.textTheme.titleSmall),
              SizedBox(height: 76.v),
              _buildPhoneNumber(context),
              SizedBox(height: 40.v),
              _buildContinue(context),
              SizedBox(height: 22.v),
              _buildWith(context),
              SizedBox(height: 14.v),
              _buildContinueWithGoogle(context),
              SizedBox(height: 22.v),
              _buildContinueWithApple(context),
              SizedBox(height: 21.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Need an account?", style: theme.textTheme.titleSmall),
                  GestureDetector(
                    onTap: () {
                      onTapTxtSignUp(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.h),
                      child: Text("Sign up", style: CustomTextStyles.titleSmallPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return CustomTextFormField(
      controller: phoneNumberController,
      hintText: "Enter your email address or phone number",
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.emailAddress,
    );
  }



  Widget _buildContinue(BuildContext context) {
    return CustomElevatedButton(
      text: "Continue",
      buttonTextStyle: CustomTextStyles.titleMediumOxygenWhiteA700,
      onPressed: () {
        onTapContinue(context);
      },
    );
  }

  Widget _buildWith(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 135.h, child: Divider()),
        Text("Or", style: CustomTextStyles.titleSmallErrorContainer_1),
        SizedBox(width: 170.h, child: Divider()),
      ],
    );
  }

  Widget _buildContinueWithGoogle(BuildContext context) {
    return CustomOutlinedButton(
      text: "Continue with Google",
      onPressed: () {
        onTapContinueWithGoogle(context);
      },
    );
  }

  Widget _buildContinueWithApple(BuildContext context) {
    return CustomOutlinedButton(
      text: "Continue with Apple",
      buttonStyle: CustomButtonStyles.outlineBlueGrayTL10,
      buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
      onPressed: () {
        onTapContinueWithApple(context);
      },
    );
  }

  onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.passwordScreen);
  }

  onTapContinueWithGoogle(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  onTapContinueWithApple(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  onTapTxtSignUp(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.createAccountScreen);
  }
}
