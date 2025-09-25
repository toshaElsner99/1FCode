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

class AddBankManuallyScreen extends StatefulWidget {
  const AddBankManuallyScreen({super.key});

  @override
  State<AddBankManuallyScreen> createState() => _AddBankManuallyScreenState();
}

class _AddBankManuallyScreenState extends State<AddBankManuallyScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _accountHolderController =
      TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _branchNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Focus nodes
  final FocusNode _accountHolderFocus = FocusNode();
  final FocusNode _bankNameFocus = FocusNode();
  final FocusNode _branchNameFocus = FocusNode();
  final FocusNode _ifscCodeFocus = FocusNode();
  final FocusNode _balanceFocus = FocusNode();
  final FocusNode _notesFocus = FocusNode();

  // State variables
  String? _selectedAccountType;
  PlatformFile? _selectedFile;
  bool _isUploading = false;

  final List<String> _accountTypes = [
    AppCommonString.savings,
    AppCommonString.current,
    AppCommonString.fixedDeposit,
    AppCommonString.recurringDeposit,
  ];

  @override
  void dispose() {
    _accountHolderController.dispose();
    _bankNameController.dispose();
    _branchNameController.dispose();
    _ifscCodeController.dispose();
    _balanceController.dispose();
    _notesController.dispose();

    _accountHolderFocus.dispose();
    _bankNameFocus.dispose();
    _branchNameFocus.dispose();
    _ifscCodeFocus.dispose();
    _balanceFocus.dispose();
    _notesFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(title: AppCommonString.addBankDetails),
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
                  AppCommonString.enterYourBankDetails,
                  style: AppTextStyles.medium.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 6),
                Text(
                  AppCommonString.pleaseFillRequiredDetails,
                  style: AppTextStyles.medium
                      .copyWith(color: AppColor.greyText, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // Account Holder Name
                _buildTextField(
                  label: AppCommonString.accountHolderName,
                  controller: _accountHolderController,
                  focusNode: _accountHolderFocus,
                  validator: AppUtils.instance.validateAccountHolderName,
                  maxLength: 50,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Bank Name
                _buildTextField(
                  label: AppCommonString.bankName,
                  controller: _bankNameController,
                  focusNode: _bankNameFocus,
                  validator: AppUtils.instance.validateBankName,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Branch Name
                _buildTextField(
                  label: AppCommonString.branchName,
                  controller: _branchNameController,
                  focusNode: _branchNameFocus,
                  validator: AppUtils.instance.validateBranchName,
                  maxLength: 100,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s&.,-]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Account Type Dropdown
                _buildDropdownField(isRequired: true),
                const SizedBox(height: 16),

                // IFSC Code
                _buildTextField(
                  label: AppCommonString.ifscCode,
                  controller: _ifscCodeController,
                  focusNode: _ifscCodeFocus,
                  validator: AppUtils.instance.validateIFSCCode,
                  maxLength: 11,
                  keyboardType: TextInputType.text,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')), UpperCaseTextFormatter()],
                  isRequired: true,
                ),
                const SizedBox(height: 16),

                // Balance
                _buildTextField(
                  label: AppCommonString.balance,
                  controller: _balanceController,
                  focusNode: _balanceFocus,
                  keyboardType: TextInputType.number,
                  validator: AppUtils.instance.validateBalance,
                  maxLength: 15,
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  isRequired: true,
                ),
                const SizedBox(height: 24),

                // Upload Statement Section
                _buildUploadSection(isRequired: true),
                const SizedBox(height: 24),

                // Notes Section
                _buildNotesSection(isRequired: false),
                 const SizedBox(height: 32),

                 AppButton(
                   text: AppCommonString.saveBankDetails,
                   onPressed: _saveBankDetails,
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
          isRequired ? '${AppCommonString.accountType}*' : AppCommonString.accountType,
          style: AppTextStyles.medium.copyWith(
            fontSize: 14,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _showAccountTypeDialog,
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
                    _selectedAccountType ?? AppCommonString.selectAccountType,
                    style: AppTextStyles.regular.copyWith(
                      fontSize: 14,
                      color: _selectedAccountType != null
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

  Widget _buildUploadSection({bool isRequired = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? '${AppCommonString.uploadStatement}*' : AppCommonString.uploadStatement,
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
          AppCommonString.uploadBankStatement,
          style: AppTextStyles.medium.copyWith(
            fontSize: 12,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppCommonString.maxFileSize,
          style: AppTextStyles.regular.copyWith(
            fontSize: 12,
            color: AppColor.greyText,
          ),
        ),
      ],
    );
  }

  Widget _buildNotesSection({bool isRequired = false}) {
    return AppTextField(
      controller: _notesController,
      focusNode: _notesFocus,
      maxLines: 4,
      maxLength: 500,
      validator: AppUtils.instance.validateNotes,
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
      label: isRequired ? '${AppCommonString.notes}*' : AppCommonString.notes,
    );
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  void _showAccountTypeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            AppCommonString.accountType,
            style: AppTextStyles.semiBold.copyWith(
              fontSize: 16,
              color: AppColor.blackColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _accountTypes.map((type) {
              return ListTile(
                title: Text(
                  type,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedAccountType = type;
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

  void _saveBankDetails() {
    if (_formKey.currentState!.validate() && _selectedAccountType != null && _selectedFile != null) {
      // TODO: Implement save functionality
      PopupService.instance.showSuccessPopupWithAutoDismiss(
        context,
        AppCommonString.bankAddedSuccessfully,
        message: AppCommonString.bankAddedSuccessMessage,
        delay: const Duration(seconds: 2),
        onDismiss: () {
          // Navigate back or to next screen
          Navigator.pop(context);
        },
      );
    } else if (_selectedAccountType == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseSelectAccountType,
        backgroundColor: AppColor.redColor,
      );
    } else if (_selectedFile == null) {
      AppUtils.instance.showSnackBar(
        context,
        AppCommonString.pleaseUploadStatement,
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
