import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';
import 'package:park_notify/widgets/custom_text_form_field.dart';

class CustomPhoneNumber extends StatelessWidget {
  CustomPhoneNumber({
    Key? key,
    required this.country,
    required this.onTap,
    required this.controller,
  }) : super(
    key: key,
  );

  final Country country;
  final Function(Country) onTap;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.v, // Adjusted height to match text field height
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(10.h),
        border: Border.all(
          color: appTheme.blueGray100,
          width: 1.h,
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _openCountryPicker(context);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.v, horizontal: 15.h),
              child: Text(
                "+${country.phoneCode}",
                style: CustomTextStyles.titleSmallOnErrorContainer,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.v, horizontal: 8.h),
              child: CustomTextFormField(
                controller: controller,
                hintText: "Enter your phone number",
                textInputType: TextInputType.phone,
                contentPadding: EdgeInsets.zero, // Remove default content padding
                borderDecoration: InputBorder.none, // Remove default border decoration
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      CountryPickerUtils.getDefaultFlagImage(country),
      Container(
        margin: EdgeInsets.only(left: 10.h),
        width: 60.h,
        child: Text(
          "+${country.phoneCode}",
          style: TextStyle(fontSize: 14.fSize),
        ),
      ),
      const SizedBox(width: 8.0),
      Flexible(
        child: Text(
          country.name,
          style: TextStyle(fontSize: 14.fSize),
        ),
      ),
    ],
  );

  void _openCountryPicker(BuildContext context) => showDialog(
    context: context,
    builder: (context) => CountryPickerDialog(
      searchInputDecoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(fontSize: 14.fSize),
      ),
      isSearchable: true,
      title: Text('Select your phone code',
          style: TextStyle(fontSize: 14.fSize)),
      onValuePicked: (Country country) => onTap(country),
      itemBuilder: _buildDialogItem,
    ),
  );
}
