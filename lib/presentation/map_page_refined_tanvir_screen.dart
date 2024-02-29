import 'package:park_notify/widgets/custom_search_view.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class MapPageRefinedTanvirScreen extends StatelessWidget {
  MapPageRefinedTanvirScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: SizeUtils.width,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgGroup87,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 735.v),
                _buildScrollView(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildScrollView(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.h),
          padding: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 23.v,
          ),
          decoration: AppDecoration.outlineOnErrorContainer.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 56.h,
                child: Divider(
                  color: theme.colorScheme.secondaryContainer,
                ),
              ),
              SizedBox(height: 21.v),
              CustomSearchView(
                controller: searchController,
                hintText: "Where to?",
                contentPadding: EdgeInsets.symmetric(vertical: 9.v),
                borderDecoration:
                    SearchViewStyleHelper.outlineOnPrimaryContainer,
              ),
              SizedBox(height: 21.v),
            ],
          ),
        ),
      ),
    );
  }
}
