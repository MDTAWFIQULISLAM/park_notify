import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({Key? key})
      : super(
    key: key,
  );

  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

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
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                  left: 35.h,
                  top: 82.v,
                  right: 35.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 17.h),
                      child: Text(
                        "You are almost there..",
                        style: theme.textTheme.headlineSmall,
                      ),
                    ),
                    SizedBox(height: 57.v),
                    CustomTextFormField(
                      controller: passwordController,
                      hintText: "Please Enter Your Password",
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.visiblePassword,
                      suffix: Container(
                        margin: EdgeInsets.fromLTRB(30.h, 12.v, 16.h, 11.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgEyefill,
                          height: 18.adaptSize,
                          width: 18.adaptSize,
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 41.v,
                      ),
                      obscureText: true,
                      contentPadding: EdgeInsets.only(
                        left: 13.h,
                        top: 11.v,
                        bottom: 11.v,
                      ),
                    ),
                    SizedBox(height: 28.v),
                    _buildRememberMe(context),
                    SizedBox(height: 27.v),
                    CustomElevatedButton(
                      text: "Continue",
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRememberMe(BuildContext context) {
    return CustomCheckboxButton(
      text: "Remember Me",
      value: rememberMe,
      padding: EdgeInsets.symmetric(vertical: 1.v),
      onChange: (value) {
        rememberMe = value;
      },
    );
  }
}
