import 'package:flutter/material.dart';
import 'package:oneFCode/utils/app_colors.dart';
import 'package:oneFCode/utils/app_text_styles.dart';
import 'package:oneFCode/utils/app_common_strings.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  
  final List<Map<String, dynamic>> questions = [
    {
      'question': AppCommonString.question1,
      'options': [
        {
          'title': AppCommonString.wealthCreation,
          'description': AppCommonString.wealthCreationDesc,
        },
        {
          'title': AppCommonString.financialFreedom,
          'description': AppCommonString.financialFreedomDesc,
        },
        {
          'title': AppCommonString.assetDiversification,
          'description': AppCommonString.assetDiversificationDesc,
        },
        {
          'title': AppCommonString.passiveIncome,
          'description': AppCommonString.passiveIncomeDesc,
        },
      ],
    },
    {
      'question': AppCommonString.question2,
      'options': [
        {
          'title': AppCommonString.shortTerm,
          'description': AppCommonString.shortTermDesc,
        },
        {
          'title': AppCommonString.mediumTerm,
          'description': AppCommonString.mediumTermDesc,
        },
        {
          'title': AppCommonString.longTerm,
          'description': AppCommonString.longTermDesc,
        },
        {
          'title': AppCommonString.flexible,
          'description': AppCommonString.flexibleDesc,
        },
      ],
    },
    {
      'question': AppCommonString.question3,
      'options': [
        {
          'title': AppCommonString.conservative,
          'description': AppCommonString.conservativeDesc,
        },
        {
          'title': AppCommonString.moderate,
          'description': AppCommonString.moderateDesc,
        },
        {
          'title': AppCommonString.aggressive,
          'description': AppCommonString.aggressiveDesc,
        },
        {
          'title': AppCommonString.veryAggressive,
          'description': AppCommonString.veryAggressiveDesc,
        },
      ],
    },
    {
      'question': AppCommonString.question4,
      'options': [
        {
          'title': AppCommonString.under10k,
          'description': AppCommonString.under10kDesc,
        },
        {
          'title': AppCommonString.tenToFiftyK,
          'description': AppCommonString.tenToFiftyKDesc,
        },
        {
          'title': AppCommonString.fiftyToHundredK,
          'description': AppCommonString.fiftyToHundredKDesc,
        },
        {
          'title': AppCommonString.overHundredK,
          'description': AppCommonString.overHundredKDesc,
        },
      ],
    },
    {
      'question': AppCommonString.question5,
      'options': [
        {
          'title': AppCommonString.beginner,
          'description': AppCommonString.beginnerDesc,
        },
        {
          'title': AppCommonString.intermediate,
          'description': AppCommonString.intermediateDesc,
        },
        {
          'title': AppCommonString.advanced,
          'description': AppCommonString.advancedDesc,
        },
        {
          'title': AppCommonString.expert,
          'description': AppCommonString.expertDesc,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightOrangeColor,
      body: Column(
        children: [
            // Custom App Bar
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColor.lightOrangeColor, // Light beige color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      // Back button (only show if not first question)
                      if (currentQuestionIndex > 0)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentQuestionIndex--;
                              selectedAnswerIndex = null;
                            });
                          },
                          child: Icon(
                            Icons.chevron_left,
                            color: AppColor.blackColor,
                            size: 24,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          
          // Main Content
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Question
                    Text(
                      'Q.${currentQuestionIndex + 1} ${questions[currentQuestionIndex]['question']}',
                      style: AppTextStyles.medium.copyWith(
                        fontSize: 20,
                        color: AppColor.blackColor,
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Answer options
                    Expanded(
                      child: ListView.builder(
                        itemCount: questions[currentQuestionIndex]['options'].length,
                        itemBuilder: (context, index) {
                          final option = questions[currentQuestionIndex]['options'][index];
                          final isSelected = selectedAnswerIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedAnswerIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected ? AppColor.primary : AppColor.textFieldBorderColor,
                                  width: isSelected ? 2 : 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.blackColor.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option['title'],
                                    style: AppTextStyles.medium.copyWith(
                                      fontSize: 16,
                                      color: AppColor.blackColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    option['description'],
                                    style: AppTextStyles.medium.copyWith(
                                      fontSize: 14,
                                      color: AppColor.greyText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Next/Complete button
                    Center(
                      child: GestureDetector(
                        onTap: selectedAnswerIndex != null ? _handleNext : null,
                        child: Text(
                          currentQuestionIndex == questions.length - 1 ? AppCommonString.complete : AppCommonString.next,
                          style: AppTextStyles.semiBold.copyWith(
                            fontSize: 18,
                            color: selectedAnswerIndex != null ? AppColor.primary : AppColor.greyText.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Progress bar with orange outline
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                          color: AppColor.primary,
                          width: 1,
                        ),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: (currentQuestionIndex + 1) / questions.length,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
      });
    } else {
      // Quiz completed
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Quiz Completed!',
            style: AppTextStyles.bold.copyWith(
              fontSize: 20,
              color: AppColor.blackColor,
            ),
          ),
          content: Text(
            'Thank you for completing the investment quiz. Your responses will help us provide personalized recommendations.',
            style: AppTextStyles.regular.copyWith(
              fontSize: 16,
              color: AppColor.greyText,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous screen
              },
              child: Text(
                'Continue',
                style: AppTextStyles.semiBold.copyWith(
                  fontSize: 16,
                  color: AppColor.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
