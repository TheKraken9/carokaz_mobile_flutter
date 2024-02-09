import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mada_jeune/navigation_menu.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => Get.offNamed('/login'), // Redirection vers la route '/home'
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
          textStyle: Theme.of(context).textTheme.bodySmall,
        ),
        child: const Text('Sauter'),
      ),
    );
  }
}