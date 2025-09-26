import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';

class DeleteAccountDialog extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;

  const DeleteAccountDialog({
    super.key,
    this.onDelete,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            // Title
            Text(
              AppCommonString.deleteAccount,
              style: AppTextStyles.medium.copyWith(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(height: 16),
            
            // Description
            Text(
             "${AppCommonString.deleteAccountConfirmation} ${AppCommonString.deleteAccountWarning}",
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 14,
                color: AppColor.greyText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            
            // Delete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDelete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  foregroundColor: AppColor.whiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppCommonString.yesDeleteAcc,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 16,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            
            // Cancel Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCancel ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.screenBgColor,
                  foregroundColor: AppColor.blackColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  AppCommonString.cancel,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    VoidCallback? onDelete,
    VoidCallback? onCancel,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DeleteAccountDialog(
        onDelete: onDelete,
        onCancel: onCancel,
      ),
    );
  }
}
