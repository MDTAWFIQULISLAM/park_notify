import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
    fontSize: 18.fSize,
  );
  static get bodyLargeOxygen => theme.textTheme.bodyLarge!.oxygen.copyWith(
    fontWeight: FontWeight.w400,
  );
  static get bodyLargeOxygenPrimary =>
      theme.textTheme.bodyLarge!.oxygen.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeOxygenff000000 =>
      theme.textTheme.bodyLarge!.oxygen.copyWith(
        color: Color(0XFF000000),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeOxygenff0274ba =>
      theme.textTheme.bodyLarge!.oxygen.copyWith(
        color: Color(0XFF0274BA),
        fontWeight: FontWeight.w400,
      );
  static get bodyLargeff000000 => theme.textTheme.bodyLarge!.copyWith(
    color: Color(0XFF000000),
    fontSize: 18.fSize,
    fontWeight: FontWeight.w400,
  );
  static get bodyLargeff0274ba => theme.textTheme.bodyLarge!.copyWith(
    color: Color(0XFF0274BA),
    fontSize: 18.fSize,
    fontWeight: FontWeight.w400,
  );
  static get bodyMediumSecondaryContainer =>
      theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 15.fSize,
      );
  // Headline text style
  static get headlineLargeBold => theme.textTheme.headlineLarge!.copyWith(
    fontWeight: FontWeight.w700,
  );
  // Title text style
  static get titleLargeOxygen => theme.textTheme.titleLarge!.oxygen.copyWith(
    fontWeight: FontWeight.w400,
  );
  static get titleLargeOxygenBold =>
      theme.textTheme.titleLarge!.oxygen.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleLargeOxygenBold_1 =>
      theme.textTheme.titleLarge!.oxygen.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get titleLargeOxygenWhiteA700 =>
      theme.textTheme.titleLarge!.oxygen.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumOxygenWhiteA700 =>
      theme.textTheme.titleMedium!.oxygen.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumOxygenWhiteA700Bold =>
      theme.textTheme.titleMedium!.oxygen.copyWith(
        color: appTheme.whiteA700,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumff0274ba => theme.textTheme.titleMedium!.copyWith(
    color: Color(0XFF0274BA),
  );
  static get titleSmallBluegray400 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.blueGray400,
    fontSize: 15.fSize,
  );
  static get titleSmallErrorContainer => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.errorContainer,
    fontSize: 15.fSize,
  );
  static get titleSmallErrorContainer_1 => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.errorContainer,
  );
  static get titleSmallGray50001 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.gray50001,
  );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.onErrorContainer.withOpacity(1),
  );
  static get titleSmallOnPrimary => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.onPrimary,
  );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.primary,
  );
  static get titleSmallPrimaryContainer => theme.textTheme.titleSmall!.copyWith(
    color: theme.colorScheme.primaryContainer,
  );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
    color: appTheme.whiteA700,
    fontSize: 15.fSize,
  );
}

extension on TextStyle {
  TextStyle get oxygen {
    return copyWith(
      fontFamily: 'Oxygen',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
