import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';

class TRatingAndShare extends StatelessWidget {
  const TRatingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
          children: [
            const Icon(Iconsax.star5, color: Colors.amber, size: 24),
            const SizedBox(width: TSizes.spaceBtwItems/2),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: 'note : 1.0', style: Theme.of(context).textTheme.bodyLarge),
                      //const TextSpan(text: '(195)'),
                    ]
                )
            )
          ],
        ),
        IconButton(onPressed: () {}, icon: const Icon(Iconsax.share, size: TSizes.iconMd))
      ],
    );
  }
}