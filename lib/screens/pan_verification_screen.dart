import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_common_textfields.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/utils/validators.dart';
import 'package:oneFCode/services/storage_service/storage_keys.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import 'package:oneFCode/widgets/common_popup.dart';

import '../services/storage_service/storage_service.dart';

class PanVerificationScreen extends StatefulWidget {
  const PanVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PanVerificationScreen> createState() => _PanVerificationScreenState();
}

class _PanVerificationScreenState extends State<PanVerificationScreen> {
  final _panController = TextEditingController();
  final _nameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();

  final _panFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _dayFocus = FocusNode();
  final _monthFocus = FocusNode();
  final _yearFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _panController.dispose();
    _nameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(title: AppCommonString.panVerification),
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppCommonString.enterYourPanDetails,
              style: AppTextStyles.medium.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 6),
            Text(
              AppCommonString.enterYourPanDetailsSub,
              style: AppTextStyles.medium.copyWith(color: AppColor.greyText, fontSize: 14),
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: AppCommonString.enterPanNumber,
              controller: _panController,
              keyboardType: TextInputType.text,
              focusNode: _panFocus,
              validator: (value) => AppValidators.instance.validatePan(value),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: AppCommonString.name,
              controller: _nameController,
              keyboardType: TextInputType.name,
              focusNode: _nameFocus,
              validator: (value) => AppValidators.instance.validatePanName(value)
            ),
            const SizedBox(height: 16),
            Text(
              AppCommonString.dateOfBirth,
              style: AppTextStyles.regular.copyWith(color: AppColor.blackColor),
            ),
            const SizedBox(height: 6),
            _DobSegmented(
              dayController: _dayController,
              monthController: _monthController,
              yearController: _yearController,
              dayFocus: _dayFocus,
              monthFocus: _monthFocus,
              yearFocus: _yearFocus,
            ),
            const SizedBox(height: 16),
            Text(
              AppCommonString.panNote,
              style: AppTextStyles.medium.copyWith(color: AppColor.greyText, fontSize: 12),
            ),
            const Spacer(),
            AppButton(
              text: AppCommonString.continueText,
              onPressed: () {
                // Normalize single-digit day/month to two digits by prefixing 0
                final day = _dayController.text.trim();
                final month = _monthController.text.trim();
                final year = _yearController.text.trim();
                if (day.length == 1) _dayController.text = '0$day';
                if (month.length == 1) _monthController.text = '0$month';
                if (year.isNotEmpty) _yearController.text = year; // no padding for year

                final dobError = AppValidators.instance.validateDobParts(
                  _dayController.text,
                  _monthController.text,
                  _yearController.text,
                );
                setState(() {});
                if (_formKey.currentState!.validate() && dobError == null) {
                  final parts = _nameController.text.trim().split(' ');
                  final first = parts.isNotEmpty ? parts.first : '';
                  final last = parts.length > 1 ? parts.sublist(1).join(' ') : '';
                  // Save name; mobile assumed saved at sign-in
                  StorageService.instance.setString(StorageKeys.firstName, first);
                  StorageService.instance.setString(StorageKeys.lastName, last);
                  PopupService.instance.showSuccessPopupWithAutoDismiss(
                    context,
                    AppCommonString.panVerifiedSuccess,
                    onDismiss: () =>  RouteConstant.bottomNavigationBarScreen.pushNamedAndRemoveUntil(),
                  );
                }
              },
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _DobSegmented extends StatelessWidget {
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;
  final FocusNode dayFocus;
  final FocusNode monthFocus;
  final FocusNode yearFocus;

  const _DobSegmented({
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.dayFocus,
    required this.monthFocus,
    required this.yearFocus,
  });

  @override
  Widget build(BuildContext context) {
    final error = AppValidators.instance.validateDobParts(
      dayController.text,
      monthController.text,
      yearController.text,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColor.textFieldBorderColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(child: _segmentField(controller: dayController, focusNode: dayFocus, hint: AppCommonString.day, maxLength: 2)),
              _divider(),
              Expanded(child: _segmentField(controller: monthController, focusNode: monthFocus, hint: AppCommonString.month, maxLength: 2)),
              _divider(),
              Expanded(child: _segmentField(controller: yearController, focusNode: yearFocus, hint: AppCommonString.year, maxLength: 4)),
            ],
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 6),
          Text(
            error,
            style: AppTextStyles.medium.copyWith(color: AppColor.redColor, fontSize: 12),
          ),
        ],
      ],
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      width: 1,
      height: 28,
      color: AppColor.textFieldBorderColor,
    );
  }

  Widget _segmentField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    required int maxLength,
  }) {
    return AppTextField(
      label: '',
      showLabel: false,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      hint: hint,
      textAlign: TextAlign.center,
      contentPaddingOverride: const EdgeInsets.symmetric(vertical: 12),
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintTextStyle: AppTextStyles.medium.copyWith(color: AppColor.greyText),
    );
  }
}


