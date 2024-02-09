import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mada_jeune/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/widget/onboarding_dot_navigation.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/widget/onboarding_next_button.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/widget/onboarding_page.dart';
import 'package:mada_jeune/features/authentication/screens/onboarding/widget/onboardskip.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.lightLogo,
                title: TTexts.onBoardingTitle1,
                subtitle: TTexts.onBoardingSubtitle1,
              ),
              OnBoardingPage(
                image: TImages.lightLogo,
                title: TTexts.onBoardingTitle2,
                subtitle: TTexts.onBoardingSubtitle2,
              ),
              OnBoardingPage(
                image: TImages.lightLogo,
                title: TTexts.onBoardingTitle3,
                subtitle: TTexts.onBoardingSubtitle3,
              ),
            ],
          ),
          const OnBoardingSkip(),

          const OnBoardingDotNavigation(),
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}




