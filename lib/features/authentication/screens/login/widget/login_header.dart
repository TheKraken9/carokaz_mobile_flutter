import 'package:flutter/material.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.lightLogo : TImages.darkLogo),
        ),
        Text(
          TTexts.onBoardingTitle1,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: TSizes.sm),
        Text(
          TTexts.onBoardingSubtitle1,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
