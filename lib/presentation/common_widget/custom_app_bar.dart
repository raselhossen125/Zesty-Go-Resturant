import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../const/app_const_assets.dart';
import '../const/app_const_dimensions.dart';
import '../const/app_const_theme.dart'; // Add this for AppConstColor
import '../const/styles.dart'; // Add this for typography helpers
import 'custom_svg_image.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final bool isBackButtonExist;
  final Widget? menuWidget;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final VoidCallback? onBackPress;
  final bool isBorderExist;
  final bool centerTitle;
  final bool isLeadingText;
  final Color? titleColor;
  final Color? leadingIconColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.leadingWidget,
    this.isBackButtonExist = true,
    this.menuWidget,
    this.backgroundColor,
    this.titleStyle,
    this.onBackPress,
    this.isBorderExist = false,
    this.centerTitle = true,
    this.isLeadingText = false,
    this.titleColor,
    this.leadingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ?? Colors.transparent, // Design onujayi transparent
      surfaceTintColor: Colors.transparent,
      title:
          titleWidget ??
          Text(
            title,
            style:
                titleStyle ??
                headline(context)?.copyWith(
                  color: titleColor ?? AppConstColor.textBlackColor,
                  fontSize: Dimensions.FONT_SIZE_OVER_LARGE,
                ),
          ),
      leading: isBackButtonExist
          ? IconButton(
              icon: CustomSvgImage(
                imagePath: AppConstAssets.arrowLeftSvg,
                height: 24,
                width: 24,
                color: leadingIconColor ?? AppConstColor.textBlackColor,
              ),
              onPressed: onBackPress ?? () => Get.back(),
            )
          : leadingWidget ?? const SizedBox.shrink(),
      elevation: 0,
      actions: menuWidget != null
          ? [menuWidget!, const SizedBox(width: 10)]
          : null,
      centerTitle: centerTitle,
      leadingWidth: isBackButtonExist
          ? 52
          : (isLeadingText ? 150 : (leadingWidget != null ? 52 : 16)),
      titleSpacing: 0,
      shape: isBorderExist
          ? Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.1),
                width: 1,
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 56);
}
