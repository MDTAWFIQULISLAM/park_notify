import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/global/common/toast.dart';
import 'package:park_notify/presentation/user/firebase_auth_impl/firebase_auth_services.dart';
import 'package:park_notify/widgets/custom_elevated_button.dart';
import 'package:park_notify/widgets/custom_outlined_button.dart';
import 'package:park_notify/widgets/custom_phone_number.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

 @override
  State<StatefulWidget> createState() => _CreateAccountScreenState();
    
}

class _CreateAccountScreenState extends State<CreateAccountScreen>{

  
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

   @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  Country selectedCountry = CountryPickerUtils.getCountryByPhoneCode('44');

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool _obscureText = true; // Initially obscure the text

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
              _buildPassword(context, _obscureText),
              SizedBox(height: 15.v), // Add space between Password and Confirm Password
              _buildConfirmPassword(context, _obscureText),
              SizedBox(height: 19.v),
              _buildContinueButton(context),
              SizedBox(height: 22.v),
              _buildWith(context), // Add this line to include the "Or" section
              SizedBox(height: 22.v),
              _buildContinueWithGoogle(context),
              SizedBox(height: 22.v),
              _buildContinueWithApple(context),
              SizedBox(height: 22.v),
              _buildSignInLink(context),
            ],
          ),
        ),
      ),
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

  Widget _buildPassword(BuildContext context, bool obscureText) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                controller: passwordController,
                hintText: "Enter your password",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                obscureText: obscureText, // Use the obscureText property
                contentPadding: EdgeInsets.only(left: 13.h, top: 11.v, bottom: 11.v),
              ),
              GestureDetector(
                onTap: () {
                  // Toggle the password visibility
                  obscureText = !obscureText;
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 12.v, 17.h, 11.v),
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmPassword(BuildContext context, bool obscureText) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Confirm Password", style: theme.textTheme.bodyMedium),
          SizedBox(height: 7.v),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              CustomTextFormField(
                controller: confirmPasswordController,
                hintText: "Confirm your password",
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.visiblePassword,
                obscureText: obscureText, // Use the obscureText property
                contentPadding: EdgeInsets.only(left: 13.h, top: 11.v, bottom: 11.v),
              ),
              GestureDetector(
                onTap: () {
                  // Toggle the password visibility
                  obscureText = !obscureText;
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 12.v, 17.h, 11.v),
                  child: Icon(
                    obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildSignInLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account? ", style: theme.textTheme.titleSmall),
        GestureDetector(
          onTap: () {
            onTapTxtSignIn(context);
          },
          child: Text("Sign In", style: CustomTextStyles.titleSmallPrimary),
        ),
      ],
    );
  }

  
  //sign in methods
  
  
  void onTapContinue(BuildContext context) {
    _signUp();
     Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
  }

  Future<void> onTapContinueWithGoogle(BuildContext context) async {
   final GoogleSignIn _googleSignIn = GoogleSignIn();

   try{

   final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
   
   if(googleSignInAccount != null){
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    Navigator.pushNamed(context, AppRoutes.registerYourVehicleScreen);
   }

   }catch(e){

    showToast(message: "Some error occured $e");
   }
  }

  
  void onTapContinueWithApple(BuildContext context) {
    // Implement Apple sign-in logic
  }

  
  void onTapTxtSignIn(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.signInPage);
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
