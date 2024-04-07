import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/presentation/user/firebase_auth_impl/firebase_auth_services.dart';
import 'package:park_notify/widgets/custom_checkbox_button.dart'; // Importing CustomCheckbox
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_phone_number.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';


class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateAccountScreenState();
    
}

  class _CreateAccountScreenState extends State<CreateAccountScreen>{

  final FirebaseAuthService _auth = FirebaseAuthService();


  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool agreeWithTermsConditions = false;

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('44');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          width: SizeUtils.width,
          padding: EdgeInsets.symmetric(horizontal: 34.h, vertical: 53.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Create an account", style: theme.textTheme.headlineSmall),
              SizedBox(height: 2.v),
              Text("Start avoiding parking tickets now!", style: theme.textTheme.titleSmall),
              SizedBox(height: 51.v),
              _buildEmail(context),
              SizedBox(height: 9.v),
              _buildPhoneNumber(context),
              SizedBox(height: 15.v),
              _buildPassword(context),
              SizedBox(height: 19.v),
              _buildRememberMe(context),
              SizedBox(height: 18.v),
              _buildAgreeWithTermsConditions(context),
              SizedBox(height: 29.v),
              _buildSignupButton(context),
              SizedBox(height: 22.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 9.v, bottom: 8.v),
                    child: SizedBox(width: 135.h, child: Divider()),
                  ),
                  Text("Or", style: CustomTextStyles.titleSmallErrorContainer_1),
                  Container(
                    height: 1.v,
                    width: 170.h,
                    margin: EdgeInsets.symmetric(vertical: 8.v),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(width: 170.h, child: Divider()),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(width: 170.h, child: Divider()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14.v),
              _buildContinueWithGoogle(context),
              SizedBox(height: 22.v),
              _buildContinueWithApple(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email address", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          CustomTextFormField(
            controller: emailController,
            hintText: "Enter your email",
            validator: (value){
                 if(value == null || value.trim().isEmpty || !value.contains('@')){
                        return 'Please enter a valid email address.';
                      }
               return null;
            } ,
            textInputType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Phone number", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          CustomPhoneNumber(
            country: selectedCountry,
            controller: phoneNumberController,
            onTap: (Country value) {
              selectedCountry = value;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          CustomTextFormField(
            controller: passwordController,
            hintText: "Please Enter Your Password",
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            obscureText: true,
            suffix: Container(
              margin: EdgeInsets.fromLTRB(30.h, 12.v, 17.h, 11.v),
              child: CustomImageView(
                imagePath: ImageConstant.imgEyefill,
                height: 18.adaptSize,
                width: 18.adaptSize,
              ),
            ),
            suffixConstraints: BoxConstraints(maxHeight: 41.v),
            contentPadding: EdgeInsets.only(left: 13.h, top: 11.v, bottom: 11.v),
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

  Widget _buildAgreeWithTermsConditions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Row(
        children: [
          CustomCheckbox(
            value: agreeWithTermsConditions,
            onChanged: (value) {
              agreeWithTermsConditions = value!;
            },
          ),
          SizedBox(width: 10),
          Text("Agree with Terms & Conditions", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return Column(
      children: [
        CustomElevatedButton(
          text: "Continue",
          buttonTextStyle: CustomTextStyles.titleMediumOxygenWhiteA700,
          onPressed: () {
            _signUp();
          },
        ),
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
      onPressed: () {
        onTapContinueWithApple(context);
      },
      buttonStyle: CustomButtonStyles.outlineBlueGrayTL10,
      buttonTextStyle: CustomTextStyles.titleSmallWhiteA700,
    );
  }

  void onTapContinue(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  void onTapContinueWithGoogle(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  void onTapContinueWithApple(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  void _signUp() async {
    String email = emailController.text;
    String password = passwordController.text;
    String phoneNumber= phoneNumberController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    
    if(user != null){
      print("User is successfully created");
      // navigate to next screen
      Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
    }else{
      print("Some error happened");
    }
  }


}
