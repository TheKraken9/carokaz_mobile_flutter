import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/commons/widgets/images/circular_image.dart';
import 'package:mada_jeune/commons/widgets/text/t_brand_title_text_with_verified_icon.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/enums.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: TRoundedContainer(
          showBorder: showBorder,
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(TSizes.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: TCircularImage(
                  isNetworkImage: false,
                  image: TImages.audi,
                  backgroundColor: Colors.transparent,
                  overlayColor: dark ? TColors.white : TColors.black,
                ),
              ),
              const SizedBox(width: TSizes.spaceBtwItems/2),

              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TBrandTitleWithVerifiedIcon(title: 'Audi', brandTextSize: TextSizes.large,),
                    Text(
                      '32 produits',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
              )
            ],
          )
      ),
    );
  }
}
