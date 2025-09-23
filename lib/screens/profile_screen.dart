import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/services/storage_service/storage_keys.dart';

import '../services/storage_service/storage_service.dart';
import 'package:oneFCode/widgets/app_common_textfields.dart';
import 'package:flutter/services.dart';
import 'package:oneFCode/widgets/common_popup.dart';
import 'profile_settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isFromEdit;
  const ProfileScreen({Key? key, this.isFromEdit = false}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();

  final _emailFocus = FocusNode();
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _mobileFocus = FocusNode();

  String? _photoPath;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final first = await StorageService.instance.getString(StorageKeys.firstName) ?? '';
    final last = await StorageService.instance.getString(StorageKeys.lastName) ?? '';
    final mobile = await StorageService.instance.getString(StorageKeys.mobile) ?? '';
    final email = await StorageService.instance.getString(StorageKeys.email) ?? '';
    final selfie = await StorageService.instance.getString(StorageKeys.selfiePath);
    setState(() {
      _firstNameController.text = first;
      _lastNameController.text = last;
      _mobileController.text = mobile;
      _emailController.text = email;
      _photoPath = selfie;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _emailFocus.dispose();
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _mobileFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppCommonAppBar(title: widget.isFromEdit ? AppCommonString.editProfile : AppCommonString.profile,
      backgroundColor: AppColor.screenBgColor,centerTitle: true
      ),
      backgroundColor: AppColor.screenBgColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _Avatar(photoPath: _photoPath, onChange: _pickImage),
            const SizedBox(height: 20),
            _FieldCard(
              children: [
                AppTextField(
                  label: AppCommonString.firstName,
                  controller: _firstNameController,
                  isNotEnabled: false,
                  focusNode: _firstNameFocus,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: AppCommonString.lastName,
                  controller: _lastNameController,
                  isNotEnabled: false,
                  focusNode: _lastNameFocus,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: AppCommonString.emailAddress,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _emailFocus,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  label: AppCommonString.phoneNumber,
                  controller: _mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  focusNode: _mobileFocus,
                  isNotEnabled: false,
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppButton(text: AppCommonString.save, onPressed: _save),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (file != null) {
      setState(() { _photoPath = file.path; });
      await StorageService.instance.setString(StorageKeys.selfiePath, file.path);
    }
  }

  Future<void> _save() async {
    await StorageService.instance.setString(StorageKeys.email, _emailController.text.trim());
    if (!widget.isFromEdit) {
      await StorageService.instance.setString(StorageKeys.firstName, _firstNameController.text.trim());
      await StorageService.instance.setString(StorageKeys.lastName, _lastNameController.text.trim());
      await StorageService.instance.setString(StorageKeys.mobile, _mobileController.text.trim());
    }
    PopupService.instance.showSuccessPopupWithAutoDismiss(
      context,
      AppCommonString.profileUpdatedSuccess,
      onDismiss: () {
        if (mounted) {
          Navigator.of(context).pop(); // Close current screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ProfileSettingsScreen(),
            ),
          );
        }
      },
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? photoPath;
  final VoidCallback onChange;
  const _Avatar({required this.photoPath, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: AppColor.textFieldBorderColor,
          backgroundImage: (photoPath != null && File(photoPath!).existsSync()) ? FileImage(File(photoPath!)) : null,
          child: (photoPath == null || !File(photoPath!).existsSync()) ? const Icon(Icons.person, size: 36, color: AppColor.whiteColor) : null,
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onChange,
          child: Text(AppCommonString.changePhoto, style: AppTextStyles.medium.copyWith(color: AppColor.primary,decoration: TextDecoration.underline, decorationColor: AppColor.primary)),
        ),
      ],
    );
  }
}

class _FieldCard extends StatelessWidget {
  final List<Widget> children;
  const _FieldCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: AppColor.blackColor.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(children: children),
    );
  }
}



