import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'package:oneFCode/utils/app_routes.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import 'package:oneFCode/services/storage_service/storage_keys.dart';

import '../services/storage_service/storage_service.dart';

class SelfieScreen extends StatefulWidget {
  const SelfieScreen({Key? key}) : super(key: key);

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  CameraController? _controller;
  Future<void>? _initFuture;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final front = cameras.firstWhere((cam) => cam.lensDirection == CameraLensDirection.front);
      _controller = CameraController(front, ResolutionPreset.medium, enableAudio: false);
      _initFuture = _controller!.initialize();
      setState(() {});
    } catch (e) {
      // Fall back silently; UI will show placeholder
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(title: AppCommonString.identityVerification),
      backgroundColor: AppColor.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderSection(),
            const SizedBox(height: 40),
            _PreviewSection(controller: _controller, initFuture: _initFuture),
            const SizedBox(height: 40),
            AppButton(
              text: AppCommonString.capturePhoto,
              onPressed: _onCapturePressed,
            ),
            const SizedBox(height: 30),
            _PrivacyNote(),
          ],
        ),
      ),
    );
  }

  Future<void> _onCapturePressed() async {
    try {
      if (_controller == null) return;
      await _initFuture;
      final xfile = await _controller!.takePicture();
      // Replace any previous selfie file path, deleting old file if exists
      await StorageService.instance.replaceStoredFilePath(
        key: StorageKeys.selfiePath,
        newPath: xfile.path,
      );
      RouteConstant.panVerificationScreen.pushNamed(args: {
        'selfiePath': xfile.path,
      });
    } catch (e) {
      // Optionally show error
    }
  }
}

class _HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppCommonString.takeASelfie,
          style: AppTextStyles.medium.copyWith(fontSize: 22),
        ),
        const SizedBox(height: 8),
        Text(
          AppCommonString.selfieTip,
          style: AppTextStyles.medium.copyWith(color: AppColor.greyText, fontSize: 14),
        ),
      ],
    );
  }
}

class _PreviewSection extends StatelessWidget {
  final CameraController? controller;
  final Future<void>? initFuture;

  const _PreviewSection({required this.controller, required this.initFuture});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: _buildInner(),
        ),
      ),
    );
  }

  Widget _buildInner() {
    if (controller == null || initFuture == null) {
      return _Placeholder();
    }
    return FutureBuilder<void>(
      future: initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(controller!);
        }
        return _Placeholder();
      },
    );
  }
}

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.lightOrangeColor,
      child: Icon(Icons.face_retouching_natural_rounded, size: 56, color: AppColor.greyText),
    );
  }
}

class _PrivacyNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImage.captureNoteIcon, width: 18, height: 18, color: AppColor.primary),
        const SizedBox(width: 5),
        Text(
          AppCommonString.selfiePrivacyNote,
          textAlign: TextAlign.center,
          style: AppTextStyles.medium.copyWith(color: AppColor.greyText, fontSize: 12),
        ),
      ],
    );
  }
}



