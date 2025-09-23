import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/widgets/app_common_textfields.dart';
import 'package:oneFCode/utils/validators.dart';
import 'nominees_screen.dart';

class AddNomineeScreen extends StatefulWidget {
  final Nominee? nominee;
  
  const AddNomineeScreen({Key? key, this.nominee}) : super(key: key);

  @override
  State<AddNomineeScreen> createState() => _AddNomineeScreenState();
}

class _AddNomineeScreenState extends State<AddNomineeScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _showValidationErrors = false;
  bool _isFormValid = false;
  
  // Controllers
  final _fullNameController = TextEditingController();
  final _dayController = TextEditingController();
  final _monthController = TextEditingController();
  final _yearController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _relationshipController = TextEditingController();
  final _nationalityController = TextEditingController();
  final _percentageController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  // Focus nodes
  final _fullNameFocus = FocusNode();
  final _dayFocus = FocusNode();
  final _monthFocus = FocusNode();
  final _yearFocus = FocusNode();
  final _ageFocus = FocusNode();
  final _genderFocus = FocusNode();
  final _relationshipFocus = FocusNode();
  final _nationalityFocus = FocusNode();
  final _percentageFocus = FocusNode();
  final _mobileFocus = FocusNode();
  final _emailFocus = FocusNode();

  // Dropdown values
  final List<String> _genderOptions = ['Male', 'Female', 'Other'];
  final List<String> _relationshipOptions = [
    'Spouse',
    'Son',
    'Daughter',
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Other'
  ];

  @override
  void initState() {
    super.initState();
    _populateFormFields();
    _addControllerListeners();
  }

  void _populateFormFields() {
    if (widget.nominee != null) {
      final nominee = widget.nominee!;
      _fullNameController.text = nominee.name;
      _genderController.text = nominee.relationship; // Assuming relationship maps to gender for now
      _relationshipController.text = nominee.relationship;
      _mobileController.text = nominee.phone;
      _emailController.text = nominee.email;
      _percentageController.text = nominee.allocation.replaceAll('%', '');
      
      // Parse age from name or set default (this would need to be stored in Nominee model)
      _ageController.text = '25'; // Default age, would need to be stored in Nominee model
      
      // Parse DOB (this would need to be stored in Nominee model)
      _dayController.text = '15';
      _monthController.text = '01';
      _yearController.text = '1998';
      
      _nationalityController.text = 'Indian'; // Default nationality
    } else {
      // Pre-fill mobile number with +91 prefix for new nominee
      _mobileController.text = '+91 8759846577';
    }
  }

  void _addControllerListeners() {
    _fullNameController.addListener(_validateForm);
    _dayController.addListener(_validateForm);
    _monthController.addListener(_validateForm);
    _yearController.addListener(_validateForm);
    _ageController.addListener(_validateForm);
    _genderController.addListener(_validateForm);
    _relationshipController.addListener(_validateForm);
    _nationalityController.addListener(_validateForm);
    _percentageController.addListener(_validateForm);
    _emailController.addListener(_validateForm);
  }

  void _validateForm() {
    // Check if all required fields have values
    final hasFullName = _fullNameController.text.trim().isNotEmpty;
    final hasDay = _dayController.text.trim().isNotEmpty;
    final hasMonth = _monthController.text.trim().isNotEmpty;
    final hasYear = _yearController.text.trim().isNotEmpty;
    final hasAge = _ageController.text.trim().isNotEmpty;
    final hasGender = _genderController.text.trim().isNotEmpty;
    final hasRelationship = _relationshipController.text.trim().isNotEmpty;
    final hasNationality = _nationalityController.text.trim().isNotEmpty;
    final hasPercentage = _percentageController.text.trim().isNotEmpty;
    final hasEmail = _emailController.text.trim().isNotEmpty;

    // Check if all required fields are filled
    final allRequiredFieldsFilled = hasFullName && 
        hasDay && hasMonth && hasYear && 
        hasAge && hasGender && hasRelationship && 
        hasNationality && hasPercentage && hasEmail;

    // Validate each field if they have values
    bool isValid = allRequiredFieldsFilled;
    
    if (hasFullName) {
      isValid = isValid && AppValidators.instance.validatePanName(_fullNameController.text) == null;
    }
    
    if (hasDay && hasMonth && hasYear) {
      isValid = isValid && AppValidators.instance.validateDobParts(
        _dayController.text, _monthController.text, _yearController.text
      ) == null;
    }
    
    if (hasAge) {
      isValid = isValid && AppValidators.instance.validateAge(_ageController.text) == null;
    }
    
    if (hasPercentage) {
      isValid = isValid && AppValidators.instance.validatePercentage(_percentageController.text) == null;
    }
    
    if (hasEmail) {
      isValid = isValid && AppValidators.instance.validateEmail(_emailController.text) == null;
    }

    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _relationshipController.dispose();
    _nationalityController.dispose();
    _percentageController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    
    _fullNameFocus.dispose();
    _dayFocus.dispose();
    _monthFocus.dispose();
    _yearFocus.dispose();
    _ageFocus.dispose();
    _genderFocus.dispose();
    _relationshipFocus.dispose();
    _nationalityFocus.dispose();
    _percentageFocus.dispose();
    _mobileFocus.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: widget.nominee != null ? AppCommonString.editNominee : AppCommonString.addNominee,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
      ),
      backgroundColor: AppColor.screenBgColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Form Card
                    _buildFormCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Header
            Text(
              AppCommonString.enterYourDetails,
              style: AppTextStyles.medium.copyWith(
                color: AppColor.blackColor,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 20),

            // Form Fields
            AppTextField(
              label: "${AppCommonString.fullName}*",
              controller: _fullNameController,
              focusNode: _fullNameFocus,
              validator: (value) => AppValidators.instance.validatePanName(value),
            ),
            const SizedBox(height: 16),

            Text(
              "${AppCommonString.dob}*",
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
              showValidationErrors: _showValidationErrors,
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: "${AppCommonString.age}*",
              controller: _ageController,
              focusNode: _ageFocus,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) => AppValidators.instance.validateAge(value),
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              label: AppCommonString.gender,
              controller: _genderController,
              focusNode: _genderFocus,
              options: _genderOptions,
              validator: (value) => AppValidators.instance.validateRequired(
                value,
                emptyMessage: AppCommonString.enterGenderValidation,
              ),
            ),
            const SizedBox(height: 16),

            _buildDropdownField(
              label: AppCommonString.relationshipWithYou,
              controller: _relationshipController,
              focusNode: _relationshipFocus,
              options: _relationshipOptions,
              validator: (value) => AppValidators.instance.validateRequired(
                value,
                emptyMessage: AppCommonString.enterRelationshipValidation,
              ),
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: AppCommonString.nationality,
              controller: _nationalityController,
              focusNode: _nationalityFocus,
              validator: (value) => AppValidators.instance.validateRequired(
                value,
                emptyMessage: AppCommonString.enterNationalityValidation,
              ),
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: AppCommonString.whatPercentageToAdd,
              controller: _percentageController,
              focusNode: _percentageFocus,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) => AppValidators.instance.validatePercentage(value),
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: AppCommonString.nomineeMobileNumber,
              controller: _mobileController,
              focusNode: _mobileFocus,
              keyboardType: TextInputType.phone,
              validator: (value) => AppValidators.instance.validateMobile(value),
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: AppCommonString.nomineeEmailAddress,
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => AppValidators.instance.validateEmail(value),
            ),
            const SizedBox(height: 16),
            // Next Button
            AppButton(
              text: AppCommonString.next,
              onPressed: _isFormValid ? _onNextPressed : (){},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required List<String> options,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.regular.copyWith(color: AppColor.blackColor),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: () => _showDropdownDialog(label, options, controller),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.textFieldBorderColor),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? 'Select $label' : controller.text,
                    style: AppTextStyles.medium.copyWith(
                      fontSize: 18,
                      color: controller.text.isEmpty ? AppColor.greyText : AppColor.blackColor,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.blackColor,
                ),
              ],
            ),
          ),
        ),
        if (_showValidationErrors && validator(controller.text) != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              validator(controller.text)!,
              style: AppTextStyles.regular.copyWith(
                color: AppColor.redColor,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  void _showDropdownDialog(String title, List<String> options, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.whiteColor,
          title: Text(
            'Select $title',
            style: AppTextStyles.semiBold.copyWith(color: AppColor.blackColor),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    options[index],
                    style: AppTextStyles.regular.copyWith(color: AppColor.blackColor),
                  ),
                  onTap: () {
                    controller.text = options[index];
                    Navigator.of(context).pop();
                    setState(() {});
                    _validateForm();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }



  void _saveAsDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Draft saved successfully'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _clearForm() {
    _fullNameController.clear();
    _dayController.clear();
    _monthController.clear();
    _yearController.clear();
    _ageController.clear();
    _genderController.clear();
    _relationshipController.clear();
    _nationalityController.clear();
    _percentageController.clear();
    _emailController.clear();
    setState(() {});
  }

  void _onNextPressed() {
    // Enable validation error display
    setState(() {
      _showValidationErrors = true;
    });

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
    
    if (_formKey.currentState!.validate() && dobError == null) {
      // Form is valid, proceed to next step
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nominee details saved successfully'),
          duration: Duration(seconds: 1),
        ),
      );
      // Navigate to next screen or back
      Navigator.of(context).pop();
    }
  }
}

class _DobSegmented extends StatelessWidget {
  final TextEditingController dayController;
  final TextEditingController monthController;
  final TextEditingController yearController;
  final FocusNode dayFocus;
  final FocusNode monthFocus;
  final FocusNode yearFocus;
  final bool showValidationErrors;

  const _DobSegmented({
    required this.dayController,
    required this.monthController,
    required this.yearController,
    required this.dayFocus,
    required this.monthFocus,
    required this.yearFocus,
    required this.showValidationErrors,
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
        if (showValidationErrors && error != null) ...[
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
