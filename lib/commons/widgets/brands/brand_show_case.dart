import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/brands/brand_card.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TBrandShowCase extends StatelessWidget {
  const TBrandShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
        showBorder: true,
        borderColor: TColors.darkerGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(TSizes.sm),
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            const TBrandCard(showBorder: false),
            const SizedBox(height: TSizes.spaceBtwItems),

            Row(
              children: images.map((image) => brandToProductImageWidget(image, context)).toList(),
            )
          ],
        )
    );
  }

  Widget brandToProductImageWidget(String image, context) {
    return Expanded(
      child: TRoundedContainer(
        height: 100,
        padding: const EdgeInsets.all(TSizes.md),
        margin: const EdgeInsets.only(right: TSizes.sm),
        backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
        child: Image(fit: BoxFit.contain, image: AssetImage(image),),
      ),
    );
  }
}