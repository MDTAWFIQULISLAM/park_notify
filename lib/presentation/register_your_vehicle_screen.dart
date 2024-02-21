import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class RegisterYourVehicleScreen extends StatelessWidget {
  RegisterYourVehicleScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController registrationNumberPlaceholderController =
      TextEditingController();

  bool rememberForFutureUse = false;

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
                padding: EdgeInsets.symmetric(
                  horizontal: 31.h,
                  vertical: 55.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48.v,
                      width: 252.h,
                      margin: EdgeInsets.only(left: 6.h),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 1.h),
                              child: Text(
                                "You are almost there.",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Register Your Vehicle ",
                              style: theme.textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 54.v),
                    _buildVehicleRegistration(context),
                    SizedBox(height: 17.v),
                    _buildRememberForFutureUse(context),
                    SizedBox(height: 24.v),
                    CustomElevatedButton(
                      text: "Continue ",
                      margin: EdgeInsets.only(right: 9.h),
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
  Widget _buildVehicleRegistration(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 3.h,
        right: 5.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Vehicle Registration Number",
            style: CustomTextStyles.titleSmallPrimaryContainer,
          ),
          SizedBox(height: 5.v),
          CustomTextFormField(
            controller: registrationNumberPlaceholderController,
            hintText: "Enter your Vehicle Registration Number",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRememberForFutureUse(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.h),
      child: CustomCheckboxButton(
        text: "Remember for future use",
        value: rememberForFutureUse,
        padding: EdgeInsets.symmetric(vertical: 1.v),
        onChange: (value) {
          rememberForFutureUse = value;
        },
      ),
    );
  }
}
