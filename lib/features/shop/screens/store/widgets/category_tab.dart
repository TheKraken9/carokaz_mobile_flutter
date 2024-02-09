import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/brands/brand_show_case.dart';
import 'package:mada_jeune/commons/widgets/layout/grid_layout.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
          Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const TBrandShowCase(images: [TImages.audi, TImages.renault, TImages.bmw],),
              const TBrandShowCase(images: [TImages.audi, TImages.renault, TImages.bmw],),

              TSectionHeading(title: 'Vous pourriez aimer', onPressed: () {}),
              const SizedBox(height: TSizes.spaceBtwItems),

              //TGridLayout(itemCount: 6, itemBuilder: (_, index) => const TProductCardVertical())
            ]
          )
        ),
      ],
    );
  }
}
