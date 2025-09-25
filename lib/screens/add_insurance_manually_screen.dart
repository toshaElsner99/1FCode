import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/utils/app_utils.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/widgets/app_common_textfields.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/widgets/common_popup.dart';

class AddInsuranceManuallyScreen extends StatefulWidget {
  const AddInsuranceManuallyScreen({super.key});

  @override
  State<AddInsuranceManuallyScreen> createState() => _AddInsuranceManuallyScreenState();
}

class _AddInsuranceManuallyScreenState extends State<AddInsuranceManuallyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _policyNameController = TextEditingController();
  final TextEditingController _policyNumberController = TextEditingController();
  final TextEditingController _insuranceProviderController = TextEditingController();
  final TextEditingController _sumAssuredController = TextEditingController();
  final TextEditingController _premiumAmountController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _maturityDateController = TextEditingController();

  // Focus nodes
  final FocusNode _policyNameFocus = FocusNode();
  final FocusNode _policyNumberFocus = FocusNode();
  final FocusNode _insuranceProviderFocus = FocusNode();
  final FocusNode _sumAssuredFocus = FocusNode();
  final FocusNode _premiumAmountFocus = FocusNode();
  final FocusNode _startDateFocus = FocusNode();
  final FocusNode _maturityDateFocus = FocusNode();

  // State variables
  PlatformFile? _selectedFile;
  bool _isUploading = false;
  DateTime? _selectedStartDate;
  DateTime? _selectedMaturityDate;
  String? _selectedPremiumFrequency;

  final List<String> _premiumFrequencyOptions = [
    AppCommonString.monthly,
    AppCommonString.quarterly,
    AppCommonString.halfYearly,
    AppCommonString.yearly,
  ];

  @override
  void dispose() {
    _policyNameController.dispose();
    _policyNumberController.dispose();
    _insuranceProviderController.dispose();
    _sumAssuredController.dispose();
    _premiumAmountController.dispose();
    _startDateController.dispose();
    _maturityDateController.dispose();

    _policyNameFocus.dispose();
    _policyNumberFocus.dispose();
    _insuranceProviderFocus.dispose();
    _sumAssuredFocus.dispose();
    _premiumAmountFocus.dispose();
    _startDateFocus.dispose();
    _maturityDateFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(title: AppCommonString.addInsuranceDetails),
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  AppCommonString.enterYourInsuranceDetails,
                  style: AppTextStyles.medium.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  AppCommonString.pleaseFillRequiredDetails,
                  style: AppTextStyles.medium
                      .copyWith(color: AppColor.greyText, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // Policy Name
                _buildTextField(
                  label: AppCommonString.policyName,
                  controller: _policyNameController,
                  focusNode: _policyNameFocus,
                  validator: AppUtils.instance.validatePolicyName,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Policy Number
                _buildTextField(
                  label: AppCommonString.policyNumber,
                  controller: _policyNumberController,
                  focusNode: _policyNumberFocus,
                  validator: AppUtils.instance.validatePolicyNumber,
                  maxLength: 20,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')), UpperCaseTextFormatter()],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Insurance Provider
                _buildTextField(
                  label: AppCommonString.insuranceProvider,
                  controller: _insuranceProviderController,
                  focusNode: _insuranceProviderFocus,
                  validator: AppUtils.instance.validateInsuranceProvider,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Sum Assured
                _buildTextField(
                  label: AppCommonString.sumAssured,
                  controller: _sumAssuredController,
                  focusNode: _sumAssuredFocus,
                  validator: AppUtils.instance.validateSumAssured,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Premium Amount
                _buildTextField(
                  label: AppCommonString.premiumAmount,
                  controller: _premiumAmountController,
                  focusNode: _premiumAmountFocus,
                  validator: AppUtils.instance.validatePremiumAmount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Premium Frequency Dropdown
                _buildDropdownField(isRequired: true),
                const SizedBox(height: 16),

                // Start Date
                _buildDateField(
                  label: AppCommonString.startDate,
                  selectedDate: _selectedStartDate,
                  onDateSelected: (date) => setState(() => _selectedStartDate = date),
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Maturity Date
                _buildDateField(
                  label: AppCommonString.maturityDate,
                  selectedDate: _selectedMaturityDate,
                  onDateSelected: (date) => setState(() => _selectedMaturityDate = date),
                  isRequired: true,
                ),
                const SizedBox(height: 24),

                // Upload Document Section
                _buildUploadSection(isRequired: true),
                const SizedBox(height: 32),

                AppButton(
                  text: AppCommonString.saveInsuranceDetails,
                  onPressed: _saveInsuranceDetails,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool isRequired = false,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return AppTextField(
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        maxLength: maxLength,
        keyboardType: keyboardType ?? TextInputType.none,
        inputFormatters: inputFormatters,
        style: AppTextStyles.regular.copyWith(
          fontSize: 14,
          color: AppColor.blackColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.textFieldBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.primary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColor.textFieldBorderColor),
        ),
        contentPaddingOverride: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        label: isRequired ? '$label*' : label);
  }

  Widget _buildDropdownField({bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '${AppCommonString.premiumFrequency}*' : AppCommonString.premiumFrequency,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showPremiumFrequencyDialog,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedPremiumFrequency ?? AppCommonString.selectPremiumFrequency,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: _selectedPremiumFrequency != null
                          ? AppColor.blackColor
                          : AppColor.greyText,
                    ),
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.greyText,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime) onDateSelected,
    bool isRequired = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '$label*' : label,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(label, onDateSelected),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null 
                        ? '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'
                        : label == AppCommonString.startDate 
                            ? AppCommonString.selectStartDate 
                            : AppCommonString.selectMaturityDate,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: selectedDate != null
                          ? AppColor.blackColor
                          : AppColor.greyText,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: AppColor.greyText,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadSection({bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '${AppCommonString.uploadDocument}*' : AppCommonString.uploadDocument,
          style: AppTextStyles.regular.copyWith(
            fontSize: 16,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _isUploading ? null : _uploadFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              border: Border.all(
                color: _selectedFile != null ? AppColor.primary : AppColor.textFieldBorderColor,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
              color: _selectedFile != null ? AppColor.lightOrangeColor : AppColor.whiteColor,
            ),
            child: _selectedFile != null ? _buildSelectedFileWidget() : _buildUploadPromptWidget(),
          ),
        ),
        if (_selectedFile != null) ...[
          const SizedBox(height: 8),
          Text(
            'File selected: ${_selectedFile!.name} (${_formatFileSize(_selectedFile!.size)})',
            style: AppTextStyles.regular.copyWith(
              fontSize: 12,
              color: AppColor.greenTextColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSelectedFileWidget() {
    return Column(
      children: [
        Icon(
          Icons.check_circle,
          size: 48,
          color: AppColor.greenTextColor,
        ),
        const SizedBox(height: 12),
        Text(
          AppCommonString.fileSelectedSuccessfully,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColor.greenTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppCommonString.tapToSelectDifferentFile,
          style: AppTextStyles.regular.copyWith(
            fontSize: 12,
            color: AppColor.greyText,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadPromptWidget() {
    return Column(
      children: [
        Icon(
          Icons.description_outlined,
          size: 48,
          color: AppColor.greyText,
        ),
        const SizedBox(height: 12),
        Text(
          AppCommonString.uploadDocumentText,
          style: AppTextStyles.medium.copyWith(
            fontSize: 12,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppCommonString.maxFileSizeDocument,
          style: AppTextStyles.regular.copyWith(
            fontSize: 12,
            color: AppColor.greyText,
          ),
        ),
      ],
    );
  }

  void _showPremiumFrequencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            AppCommonString.premiumFrequency,
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _premiumFrequencyOptions.map((frequency) {
              return ListTile(
                title: Text(
                  frequency,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedPremiumFrequency = frequency;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _selectDate(String label, Function(DateTime) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: label == AppCommonString.startDate 
          ? (_selectedStartDate ?? DateTime.now())
          : (_selectedMaturityDate ?? DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primary,
              onPrimary: AppColor.whiteColor,
              surface: AppColor.whiteColor,
              onSurface: AppColor.blackColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  void _uploadFile() async {
    try {
      setState(() {
        _isUploading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        
        // Validate file size (10 MB limit)
        if (file.size > 10 * 1024 * 1024) {
        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.fileSizeExceeded,
          backgroundColor: AppColor.redColor,
        );
          return;
        }

        // Validate file extension
        String extension = file.extension?.toLowerCase() ?? '';
        if (!['pdf', 'jpg', 'jpeg', 'png'].contains(extension)) {
        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.invalidFileFormat,
          backgroundColor: AppColor.redColor,
        );
          return;
        }

        setState(() {
          _selectedFile = file;
        });

        AppUtils.instance.showSnackBar(
          context,
          AppCommonString.fileSelectedSuccess,
          backgroundColor: AppColor.greenTextColor,
        );
      }
    } catch (e) {
      AppUtils.instance.showSnackBar(
        context,
        '${AppCommonString.errorSelectingFile} ${e.toString()}',
        backgroundColor: AppColor.redColor,
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  void _saveInsuranceDetails() {
    if (_formKey.currentState!.validate() && 
        _selectedStartDate != null && 
        _selectedMaturityDate != null && 
        _selectedPremiumFrequency != null && 
        _selectedFile != null) {
      // TODO: Implement save functionality
      PopupService.instance.showSuccessPopupWithAutoDismiss(
        context,
        AppCommonString.insuranceAddedSuccessfully,
        message: AppCommonString.insuranceAddedSuccessMessage,
        delay: const Duration(seconds: 2),
        onDismiss: () {
          // Navigate back or to next screen
          Navigator.pop(context);
        },
      );
    } else if (_selectedStartDate == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseSelectStartDate,
        backgroundColor: AppColor.redColor,
      );
    } else if (_selectedMaturityDate == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseSelectMaturityDate,
        backgroundColor: AppColor.redColor,
      );
    } else if (_selectedPremiumFrequency == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseSelectPremiumFrequency,
        backgroundColor: AppColor.redColor,
      );
    } else if (_selectedFile == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseUploadDocument,
        backgroundColor: AppColor.redColor,
      );
    }
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
