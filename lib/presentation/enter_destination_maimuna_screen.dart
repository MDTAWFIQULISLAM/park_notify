import 'package:park_notify/widgets/custom_search_view.dart';
import 'package:park_notify/widgets/enterdestinationmaimuna_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:park_notify/core/app_export.dart';

class EnterDestinationMaimunaScreen extends StatelessWidget {
  EnterDestinationMaimunaScreen({Key? key})
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
            horizontal: 15.h,
            vertical: 27.v,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "St",
                ),
              ),
              SizedBox(height: 30.v),
              _buildEnterDestinationMaimuna(context),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEnterDestinationMaimuna(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.h,
          right: 6.h,
        ),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (
            context,
            index,
          ) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0.v),
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
          itemCount: 5,
          itemBuilder: (context, index) {
            return EnterdestinationmaimunaItemWidget();
          },
        ),
      ),
    );
  }
}
