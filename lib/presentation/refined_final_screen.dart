import 'package:park_notify/widgets/custom_search_view.dart';
import 'package:park_notify/widgets/refinedfinal_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class RefinedFinalScreen extends StatelessWidget {
  RefinedFinalScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 17.h,
            vertical: 29.v,
          ),
          child: Column(
            children: [
              CustomSearchView(
                controller: searchController,
                hintText: "Where to?",
              ),
              SizedBox(height: 28.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 25.h),
                  child: Text(
                    "Parking places near me",
                    style: CustomTextStyles.bodyLargeOxygenPrimary,
                  ),
                ),
              ),
              SizedBox(height: 27.v),
              _buildRefinedFinal(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRefinedFinal(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 19.h,
        right: 4.h,
      ),
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (
          context,
          index,
        ) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 6.5.v),
            child: SizedBox(
              width: 349.h,
              child: Divider(
                height: 1.v,
                thickness: 1.v,
                color: theme.colorScheme.onErrorContainer.withOpacity(1),
              ),
            ),
          );
        },
        itemCount: 4,
        itemBuilder: (context, index) {
          return RefinedfinalItemWidget();
        },
      ),
    );
  }
}
