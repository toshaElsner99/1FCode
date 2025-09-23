// import 'package:flutter/material.dart';
// import 'package:oneFCode/utils/app_common_strings.dart';
// import 'package:oneFCode/utils/app_text_styles.dart';
// import 'package:oneFCode/utils/navigation_service.dart';
// import '../utils/app_image.dart';
// import '../utils/app_colors.dart';
// import '../utils/app_routes.dart';
// import '../widgets/app_button.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _textAnimation;
//   late Animation<double> _personAnimation;
//   late Animation<double> _buttonAnimation;
//   late Animation<double> _hdfcAnimation;
//   late Animation<double> _adaniAnimation;
//   late Animation<double> _relianceAnimation;
//   late Animation<double> _sbiAnimation;
//   late Animation<double> _stockAnimation;
//   late Animation<double> _tataAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );
//
//     // Logo animation - from top to position
//     _logoAnimation = Tween<double>(
//       begin: -300.0, // Start from above the screen
//       end: 70.0, // Stop at 70 padding from top
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.0, 0.7, curve: Curves.easeOutCirc),
//     ));
//
//     // Text animation - fade in from invisible to visible
//     _textAnimation = Tween<double>(
//       begin: 0.0, // Start invisible
//       end: 1.0, // End fully visible
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
//     ));
//
//     // Person image animation - fade in from invisible to visible
//     _personAnimation = Tween<double>(
//       begin: 0.0, // Start invisible
//       end: 1.0, // End fully visible
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
//     ));
//
//     // Button animation - fade in from invisible to visible
//     _buttonAnimation = Tween<double>(
//       begin: 0.0, // Start invisible
//       end: 1.0, // End fully visible
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
//     ));
//
//     // HDFC icon animation - animate from bottom of screen to position
//     _hdfcAnimation = Tween<double>(
//       begin: 800.0, // Start from bottom of screen (estimated height)
//       end: 0.0, // End at final position
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.5, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     // Adani icon animation
//     _adaniAnimation = Tween<double>(
//       begin: 800.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.55, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     // Reliance icon animation
//     _relianceAnimation = Tween<double>(
//       begin: 800.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.6, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     // SBI icon animation
//     _sbiAnimation = Tween<double>(
//       begin: 800.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.65, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     // Stock icon animation
//     _stockAnimation = Tween<double>(
//       begin: 800.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.7, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     // Tata icon animation
//     _tataAnimation = Tween<double>(
//       begin: 800.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: const Interval(0.75, 1.0, curve: Curves.easeOutCirc),
//     ));
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Base layer - splashImage
//           Center(
//             child: Image.asset(
//               AppImage.splashImage,
//               fit: BoxFit.cover,
//             ),
//           ),
//           // Top layer - splash1FCLogo with animation
//           AnimatedBuilder(
//             animation: _logoAnimation,
//             builder: (context, child) {
//               return Positioned(
//                 top: _logoAnimation.value,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Logo
//                       Image.asset(
//                         AppImage.splash1FCLogo,
//                         width: 130,
//                         fit: BoxFit.contain,
//                       ),
//                       SizedBox(height: 30),
//                       // Text logo with fade animation
//                       AnimatedBuilder(
//                         animation: _textAnimation,
//                         builder: (context, child) {
//                           return Opacity(
//                             opacity: _textAnimation.value,
//                             child: Image.asset(
//                               AppImage.splashTextLogo,
//                               width: MediaQuery.of(context).size.width / 1.5,
//                               fit: BoxFit.fitWidth,
//                             ),
//                           );
//                         },
//                       ),
//                       // SizedBox(height: 20),
//                         // Person image with fade animation
//                         AnimatedBuilder(
//                           animation: _personAnimation,
//                           builder: (context, child) {
//                             return Opacity(
//                               opacity: _personAnimation.value,
//                               child: Image.asset(
//                                 width: MediaQuery.of(context).size.width - 90,
//                                 AppImage.splashPersonImage,
//                                 fit: BoxFit.contain,
//                               ),
//                             );
//                           },
//                         ),
//                         // SizedBox(height: 20),
//                         // Get Started button with fade animation
//                         AnimatedBuilder(
//                           animation: _buttonAnimation,
//                           builder: (context, child) {
//                             return Opacity(
//                               opacity: _buttonAnimation.value,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                                 child: AppButton(
//                                   text: AppCommonString.getStarted,
//                                   onPressed: (){
//                                     // Navigate to next screen
//                                     RouteConstant.signInScreen.pushNamedAndRemoveUntil();
//                                   },
//                                 ),
//                               ));
//                           },
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           // House/Building icon (top right of coin)
//           AnimatedBuilder(
//             animation: _hdfcAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.3 + _hdfcAnimation.value,
//                 right: screenWidth * 0.15,
//                 child: Image.asset(
//                   AppImage.hdfcSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//           // SBI icon (further right)
//           AnimatedBuilder(
//             animation: _sbiAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.35 + _sbiAnimation.value,
//                 right: screenWidth * 0.05,
//                 child: Image.asset(
//                   AppImage.sbiSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//           // Stock icon (below SBI)
//           AnimatedBuilder(
//             animation: _stockAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.45 + _stockAnimation.value,
//                 right: screenWidth * 0.08,
//                 child: Image.asset(
//                   AppImage.stockSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//           // Tata icon (bottom right)
//           AnimatedBuilder(
//             animation: _tataAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.6 + _tataAnimation.value,
//                 right: screenWidth * 0.12,
//                 child: Image.asset(
//                   AppImage.tataSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//           // Reliance icon (bottom left)
//           AnimatedBuilder(
//             animation: _relianceAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.6 + _relianceAnimation.value,
//                 left: screenWidth * 0.12,
//                 child: Image.asset(
//                   AppImage.relianceSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//           // Adani icon (further left)
//           AnimatedBuilder(
//             animation: _adaniAnimation,
//             builder: (context, child) {
//               final screenHeight = MediaQuery.of(context).size.height;
//               final screenWidth = MediaQuery.of(context).size.width;
//               return Positioned(
//                 top: screenHeight * 0.55 + _adaniAnimation.value,
//                 left: screenWidth * 0.05,
//                 child: Image.asset(
//                   AppImage.adaniSplashIcon,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.contain,
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_image.dart';
import 'package:oneFCode/utils/navigation_service.dart';
import 'package:video_player/video_player.dart';

import '../utils/app_common_strings.dart';
import '../utils/app_routes.dart';
import '../widgets/app_button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(AppImage.splashVideo)
      ..initialize().then((_) {
        // Play video once initialized
        _controller.play();
        setState(() {});
      });

    // Listen for video end to navigate
    _controller.addListener(() {
      if (_controller.value.position >= _controller.value.duration  &&
          !_showButton) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fullscreen Video
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

          // Get Started Button
          Positioned(
            bottom: 30, // same spacing as in design
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              child: AppButton(
                text: AppCommonString.getStarted,
                onPressed: () {
                  RouteConstant.signInScreen.pushNamedAndRemoveUntil();
                },
              ),
            ),
          ),
        ],
      )

    );
  }
}

