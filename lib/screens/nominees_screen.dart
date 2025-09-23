import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';
import 'package:oneFCode/widgets/app_common_appbar.dart';
import 'package:oneFCode/widgets/app_button.dart';
import 'add_nominee_screen.dart';

class NomineesScreen extends StatefulWidget {
  const NomineesScreen({Key? key}) : super(key: key);

  @override
  State<NomineesScreen> createState() => _NomineesScreenState();
}

class _NomineesScreenState extends State<NomineesScreen> {
  // Sample nominees data - in real app, this would come from API/storage
  final List<Nominee> _nominees = [
    Nominee(
      name: "Sarah Johnson",
      relationship: AppCommonString.spouse,
      email: "sarah.johnson@gmail.com",
      phone: "+1 (555)123 - 458",
      allocation: "60%",
      status: NomineeStatus.accepted,
    ),
    Nominee(
      name: "Michael Smith",
      relationship: AppCommonString.brother,
      email: "michael.smith@gmail.com",
      phone: "+1 (555)987 - 654",
      allocation: "30%",
      status: NomineeStatus.rejected,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCommonAppBar(
        title: AppCommonString.nominees,
        backgroundColor: AppColor.screenBgColor,
        centerTitle: true,
        action: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppColor.blackColor),
            onPressed: _showOptionsMenu,
          ),
        ],
      ),
      backgroundColor: AppColor.screenBgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Your Nominees Section
            _buildNomineesSection(),
            const SizedBox(height: 20),

            // Add Another Nominee Section
            _buildAddNomineeSection(),
            const SizedBox(height: 20),
            // Continue Button
            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildNomineesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with count badge
        Row(
          children: [
            Text(
              AppCommonString.yourNominees,
              style: AppTextStyles.medium.copyWith(
                fontSize: 18,
                color: AppColor.blackColor,
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColor.lightOrangeColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.primary)
              ),
              child: Text(
                "${_nominees.length} ${AppCommonString.added}",
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 12,
                  color: AppColor.primary
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Nominees List
        ..._nominees.map((nominee) => _buildNomineeCard(nominee)).toList(),
      ],
    );
  }

  Widget _buildNomineeCard(Nominee nominee) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name and Actions Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nominee.name,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 16,
                          color: AppColor.blackColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        nominee.relationship,
                        style: AppTextStyles.semiBold.copyWith(
                          fontSize: 14,
                          color: AppColor.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit and Delete Icons
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset(AppImage.editIcon, width: 20,height: 20),
                      onPressed: () => _onEditNominee(nominee),
                    ),
                    IconButton(
                      icon:  Image.asset(AppImage.deleteIcon, width: 20,height: 20),
                      onPressed: () => _onDeleteNominee(nominee),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Contact Information
            Text(
              nominee.email,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 14,
                color: AppColor.greyText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              nominee.phone,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 14,
                color: AppColor.greyText,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Bottom Row with Allocation and Status
            Row(
              children: [
                // Allocation Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColor.greenBGColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.greenTextColor)
                  ),
                  child: Text(
                    "${nominee.allocation} ${AppCommonString.allocation}",
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 12,
                      color: AppColor.greenTextColor,
                    ),
                  ),
                ),
                
                const Spacer(),
                
                // Status Text
                Text(
                  nominee.status == NomineeStatus.accepted 
                      ? AppCommonString.invitationAccept
                      : AppCommonString.invitationReject,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 14,
                    color: nominee.status == NomineeStatus.accepted 
                        ? AppColor.greenTextColor 
                        : AppColor.redColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNomineeSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: InkWell(
          onTap: _onAddNominee,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Plus Icon
                Image.asset(
                  AppImage.addNomineeIcon,
                  width: 100,
                  height: 100,
                ),
                // Title
                Text(
                  AppCommonString.addAnotherNominee,
                  style: AppTextStyles.medium.copyWith(
                    fontSize: 14,
                    color: AppColor.blackColor,
                  ),
                ),
                const SizedBox(height: 5),
                // Description
                Text(
                  AppCommonString.addMoreBenefices,
                  style: AppTextStyles.regular.copyWith(
                    fontSize: 12,
                    color: AppColor.greyText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      child: AppButton(
        text: AppCommonString.continueButton,
        onPressed: _onContinue,
      ),
    );
  }

  void _showOptionsMenu() {
    // Handle options menu
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppCommonString.optionsMenuTapped),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onEditNominee(Nominee nominee) {
    // Navigate to edit nominee screen with nominee data
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddNomineeScreen(nominee: nominee),
      ),
    );
  }

  void _onDeleteNominee(Nominee nominee) {
    // Show confirmation dialog and delete nominee
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppCommonString.deleteNominee),
          content: Text('${AppCommonString.deleteNomineeConfirmation} ${nominee.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppCommonString.cancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _nominees.remove(nominee);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${nominee.name} ${AppCommonString.deletedSuccessfully}'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text(AppCommonString.delete),
            ),
          ],
        );
      },
    );
  }

  void _onAddNominee() {
    // Navigate to add nominee screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddNomineeScreen(),
      ),
    );
  }

  void _onContinue() {
    // Handle continue action
    Navigator.of(context).pop();
  }
}

// Nominee model class
class Nominee {
  final String name;
  final String relationship;
  final String email;
  final String phone;
  final String allocation;
  final NomineeStatus status;

  Nominee({
    required this.name,
    required this.relationship,
    required this.email,
    required this.phone,
    required this.allocation,
    required this.status,
  });
}

enum NomineeStatus {
  accepted,
  rejected,
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.textFieldBorderColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const radius = 12.0;
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    // Create rounded rectangle path
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(radius),
      ));

    // Create dash effect by drawing the path with dash pattern
    final dashPath = Path();
    final pathMetrics = path.computeMetrics();
    
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        dashPath.addPath(extractPath, Offset.zero);
        distance += dashWidth + dashSpace;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
