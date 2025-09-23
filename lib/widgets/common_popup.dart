import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';

class AppGifs {
  static const String doneGIF = "assets/gif/done.gif";
  static const String successGIF = "assets/gif/success.gif";
  static const String failureGIF = "assets/gif/failure.gif";
}

class PopupService {
  PopupService._internal();
  static final PopupService instance = PopupService._internal();

  /// Show success popup with dynamic text
  void showSuccessPopup(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _StatusPopup(
        message: message,
        popupType: PopupType.success,
      ),
    );
  }

  /// Auto-dismiss success popup after delay
  void showSuccessPopupWithAutoDismiss(BuildContext context, String message, {
    Duration delay = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _StatusPopup(
        message: message,
        popupType: PopupType.success,
        autoDismiss: true,
        delay: delay,
        onDismiss: onDismiss,
      ),
    );
  }

  /// Show failure popup with dynamic text
  void showFailurePopup(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _StatusPopup(
        message: message,
        popupType: PopupType.failure,
      ),
    );
  }

  /// Auto-dismiss failure popup after delay
  void showFailurePopupWithAutoDismiss(BuildContext context, String message, {
    Duration delay = const Duration(seconds: 2),
    VoidCallback? onDismiss,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _StatusPopup(
        message: message,
        popupType: PopupType.failure,
        autoDismiss: true,
        delay: delay,
        onDismiss: onDismiss,
      ),
    );
  }
}

enum PopupType { success, failure }

class ConfirmationDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required String cancelText,
    required VoidCallback onConfirm,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppColor.whiteColor,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColor.blackColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  title,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 18,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Message
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 16,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cancelButtonColor ?? AppColor.greyText,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          cancelText,
                          style: AppTextStyles.medium.copyWith(
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    
                    // Confirm Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onConfirm();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: confirmButtonColor ?? AppColor.redColor,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          confirmText,
                          style: AppTextStyles.medium.copyWith(
                            color: AppColor.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusPopup extends StatefulWidget {
  final String message;
  final PopupType popupType;
  final bool autoDismiss;
  final Duration delay;
  final VoidCallback? onDismiss;

  const _StatusPopup({
    required this.message,
    required this.popupType,
    this.autoDismiss = false,
    this.delay = const Duration(seconds: 2),
    this.onDismiss,
  });

  @override
  State<_StatusPopup> createState() => _StatusPopupState();
}

class _StatusPopupState extends State<_StatusPopup> {
  @override
  void initState() {
    super.initState();
    if (widget.autoDismiss) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          Navigator.of(context).pop();
          widget.onDismiss?.call();
        }
      });
    }
  }

  String _getGifPath() {
    switch (widget.popupType) {
      case PopupType.success:
        return AppGifs.successGIF;
      case PopupType.failure:
        return AppGifs.failureGIF;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor.whiteColor,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // GIF Container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: AppColor.whiteColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  _getGifPath(),
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print("IN errorBuilder = $error");
                    // Fallback to icon if GIF fails to load
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: widget.popupType == PopupType.success 
                            ? const Color(0xFF4CAF50) 
                            : AppColor.redColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.popupType == PopupType.success 
                            ? Icons.check 
                            : Icons.close,
                        color: AppColor.whiteColor,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.message,
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 16,
                color: AppColor.blackColor,
              ),
            ),
            if (!widget.autoDismiss) ...[
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    widget.onDismiss?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'OK',
                    style: AppTextStyles.semiBold.copyWith(color: AppColor.whiteColor),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
