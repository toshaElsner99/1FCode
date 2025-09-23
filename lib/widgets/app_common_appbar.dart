import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';

class AppCommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final double height;
  final bool centerTitle;
  final Color? backgroundColor;
  final List<Widget>? action;

  const AppCommonAppBar({
    Key? key,
    required this.title,
    this.showBack = true,
    this.height = 100, // default height
    this.centerTitle = false,
    this.backgroundColor,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColor.lightOrangeColor,
      elevation: 0,
      automaticallyImplyLeading: false, // disable default back button
      flexibleSpace: Container(
        color: backgroundColor ?? AppColor.lightOrangeColor,
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            alignment: Alignment.bottomCenter,
          child: centerTitle
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    if (showBack)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppColor.blackColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    Text(
                      title,
                      style: AppTextStyles.semiBold.copyWith(
                        fontSize: 22,
                        color: AppColor.blackColor,
                      ),
                    ),
                    if (action != null && action!.isNotEmpty)
                     ...action!
                  ],
                )
              : Row(
                  children: [
                    if (showBack)
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColor.blackColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 22,
                          color: AppColor.blackColor,
                        ),
                      ),
                    ),
                    if (action != null && action!.isNotEmpty) ...action!
                  ],
                ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
