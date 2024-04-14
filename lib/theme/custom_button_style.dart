import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A class that offers pre-defined button styles for customizing button appearance.
class CustomButtonStyles {
  // Filled button style
  static ButtonStyle get fillOnErrorContainer => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.onErrorContainer.withOpacity(1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.h),
    ),
  );
  static ButtonStyle get fillOnErrorContainerTL15 => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.onErrorContainer.withOpacity(1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.h),
    ),
  );
  static ButtonStyle get fillPrimaryTL15 => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.h),
    ),
  );

  // Outline button style
  static ButtonStyle get outlineBlueGrayTL10 => OutlinedButton.styleFrom(
    backgroundColor: theme.colorScheme.onErrorContainer.withOpacity(1),
    side: BorderSide(
      color: appTheme.blueGray100,
      width: 1,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.h),
    ),
  );
  // text button style
  static ButtonStyle get none => ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    elevation: MaterialStateProperty.all<double>(0),
  );
}
