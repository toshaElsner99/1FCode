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

class AddMutualFundManuallyScreen extends StatefulWidget {
  const AddMutualFundManuallyScreen({super.key});

  @override
  State<AddMutualFundManuallyScreen> createState() => _AddMutualFundManuallyScreenState();
}

class _AddMutualFundManuallyScreenState extends State<AddMutualFundManuallyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _fundNameController = TextEditingController();
  final TextEditingController _amcController = TextEditingController();
  final TextEditingController _folioNumberController = TextEditingController();
  final TextEditingController _investmentAmountController = TextEditingController();
  final TextEditingController _navController = TextEditingController();
  final TextEditingController _purchaseDateController = TextEditingController();

  // Focus nodes
  final FocusNode _fundNameFocus = FocusNode();
  final FocusNode _amcFocus = FocusNode();
  final FocusNode _folioNumberFocus = FocusNode();
  final FocusNode _investmentAmountFocus = FocusNode();
  final FocusNode _navFocus = FocusNode();
  final FocusNode _purchaseDateFocus = FocusNode();

  // State variables
  PlatformFile? _selectedFile;
  bool _isUploading = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _fundNameController.dispose();
    _amcController.dispose();
    _folioNumberController.dispose();
    _investmentAmountController.dispose();
    _navController.dispose();
    _purchaseDateController.dispose();

    _fundNameFocus.dispose();
    _amcFocus.dispose();
    _folioNumberFocus.dispose();
    _investmentAmountFocus.dispose();
    _navFocus.dispose();
    _purchaseDateFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(title: AppCommonString.addMutualFundDetails),
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
                  AppCommonString.enterYourMFDetails,
                  style: AppTextStyles.medium.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  AppCommonString.pleaseFillRequiredDetails,
                  style: AppTextStyles.medium
                      .copyWith(color: AppColor.greyText, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // Fund Name
                _buildTextField(
                  label: AppCommonString.fundName,
                  controller: _fundNameController,
                  focusNode: _fundNameFocus,
                  validator: AppUtils.instance.validateFundName,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // AMC
                _buildTextField(
                  label: AppCommonString.amc,
                  controller: _amcController,
                  focusNode: _amcFocus,
                  validator: AppUtils.instance.validateAMC,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Folio Number
                _buildTextField(
                  label: AppCommonString.folioNumber,
                  controller: _folioNumberController,
                  focusNode: _folioNumberFocus,
                  validator: AppUtils.instance.validateFolioNumber,
                  maxLength: 20,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')), UpperCaseTextFormatter()],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Investment Amount
                _buildTextField(
                  label: AppCommonString.investmentAmount,
                  controller: _investmentAmountController,
                  focusNode: _investmentAmountFocus,
                  validator: AppUtils.instance.validateInvestmentAmount,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Purchase Date
                _buildDateField(isRequired: true),
                const SizedBox(height: 16),

                // NAV at Purchase
                _buildTextField(
                  label: AppCommonString.navAtPurchase,
                  controller: _navController,
                  focusNode: _navFocus,
                  validator: AppUtils.instance.validateNAV,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 24),

                // Upload Document Section
                _buildUploadSection(isRequired: true),
                const SizedBox(height: 32),

                AppButton(
                  text: AppCommonString.saveMutualFundDetails,
                  onPressed: _saveMutualFundDetails,
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

  Widget _buildDateField({bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '${AppCommonString.purchaseDate}*' : AppCommonString.purchaseDate,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _selectDate,
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
                    _selectedDate != null 
                        ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                        : AppCommonString.selectPurchaseDate,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: _selectedDate != null
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

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
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

  void _saveMutualFundDetails() {
    if (_formKey.currentState!.validate() && _selectedDate != null && _selectedFile != null) {
      // TODO: Implement save functionality
      PopupService.instance.showSuccessPopupWithAutoDismiss(
        context,
        AppCommonString.mutualFundAddedSuccessfully,
        message: AppCommonString.mutualFundAddedSuccessMessage,
        delay: const Duration(seconds: 2),
        onDismiss: () {
          // Navigate back or to next screen
          Navigator.pop(context);
        },
      );
    } else if (_selectedDate == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseSelectPurchaseDate,
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
