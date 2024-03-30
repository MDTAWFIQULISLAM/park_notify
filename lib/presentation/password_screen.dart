import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart'; // Importing CustomCheckbox
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true; // Indicates whether to obscure the password

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
                Text("You are almost there..", style: theme.textTheme.headlineSmall),
                SizedBox(height: 57.v),
                _buildPasswordTextField(context),
                SizedBox(height: 28.v),
                _buildRememberMe(context),
                SizedBox(height: 27.v),
                _buildContinue(context),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          TextFormField(
            controller: passwordController,
            obscureText: _obscurePassword, // Use the obscureText property
            decoration: InputDecoration(
              hintText: "Please Enter Your Password",
              suffixIcon: IconButton(
                icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  // Toggle the visibility of the password
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 11.v, horizontal: 13.h), // Add contentPadding
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }


  Widget _buildRememberMe(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        children: [
          CustomCheckbox(
            value: rememberMe,
            onChanged: (value) {
              rememberMe = value!;
            },
          ),
          SizedBox(width: 10),
          Text("Remember Me", style: TextStyle(fontSize: 16)),
        ],
      ),
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

  void onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.mapPageRefinedTanvirScreen);
  }
}
