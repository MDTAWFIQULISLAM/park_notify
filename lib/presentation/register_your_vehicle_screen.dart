import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart'; // Importing CustomCheckbox
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class RegisterYourVehicleScreen extends StatelessWidget {
  RegisterYourVehicleScreen({Key? key}) : super(key: key);

  TextEditingController registrationNumberPlaceholderController =
  TextEditingController();

  bool rememberForFutureUse = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: SizeUtils.width,
          padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 53.v),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Register Your Vehicle", style: theme.textTheme.headlineSmall),
                SizedBox(height: 2.v),
                Text("You are almost there.", style: theme.textTheme.titleSmall),
                SizedBox(height: 51.v),
                _buildVehicleRegistration(context),
                SizedBox(height: 9.v),
                _buildRememberForFutureUse(context),
                SizedBox(height: 29.v),
                _buildContinueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleRegistration(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Vehicle Registration Number", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          CustomTextFormField(
            controller: registrationNumberPlaceholderController,
            hintText: "Enter your Vehicle Registration Number",
            textInputType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildRememberForFutureUse(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        children: [
          CustomCheckbox(
            value: rememberForFutureUse,
            onChanged: (value) {
              rememberForFutureUse = value!;
            },
          ),
          SizedBox(width: 10),
          Text("Remember for future use", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: "Continue",
          buttonTextStyle: CustomTextStyles.titleMediumOxygenWhiteA700,
          onPressed: () {
            onTapContinue(context);
          },
        ),
      ],
    );
  }

  void onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mapPage);
  }
}
