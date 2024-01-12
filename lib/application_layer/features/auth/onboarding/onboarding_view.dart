import 'package:kindergarden_mobile/application_layer/features/auth/onboarding/components/onboarding_page_element.dart';
import 'package:kindergarden_mobile/service_layer/extensions/context_extention.dart';
import 'package:kindergarden_mobile/tools/enums/duration_enums.dart';
import 'package:kindergarden_mobile/tools/enums/image_path_enums.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

enum AnimationDirection { forward, reverse }

class _OnBoardingViewState extends State<OnBoardingView> {
  int index = 0;

  final PageController _pageController = PageController(initialPage: 0);

  final List<String> _models = [
    ImagePathEnums.ss1.path,
    ImagePathEnums.ss2.path,
    ImagePathEnums.ss3.path,
    ImagePathEnums.ss4.path,
    ImagePathEnums.ss5.path,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: AnimatedContainer(
        duration: DurationEnums.themeChange.duration,
        color: context.themeColors.background,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (i) {
                  setState(() => index = i);
                },
                children: _models.map((e) => OnBoardingPageElement(imagePath: e)).toList(),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (index == _models.length - 1) {
                } else {
                  _pageController.animateToPage(index + 1, duration: DurationEnums.themeChange.duration, curve: Curves.easeIn);
                }
              },
              child: Container(
                width: context.width,
                height: context.height * 0.1,
                decoration: BoxDecoration(
                  color: context.themeColors.background,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Next", style: context.fonts.button.copyWith(color: context.textColors.filledInputForm)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
