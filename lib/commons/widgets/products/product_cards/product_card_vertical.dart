import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/styles/shadows.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/commons/widgets/icons/t_circular_icon.dart';
import 'package:mada_jeune/commons/widgets/images/rounded_image.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_price_text.dart';
import 'package:mada_jeune/commons/widgets/text/product_title_text.dart';
import 'package:mada_jeune/commons/widgets/text/t_brand_title_text_with_verified_icon.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/features/shop/screens/product_details/product_detail.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key, required this.annonceModel});

  final AnnonceModel annonceModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final dateAnnonce = DateTime.parse(annonceModel.dateAnnonce);
    final today = DateTime.now();
    final dateToday = DateTime(today.year, today.month, today.day);
    final bool moinsDunJour = dateToday.difference(dateAnnonce).inDays == 0;
    final bool moinsDeDeuxJour = dateToday.difference(dateAnnonce).inDays == 1;
    final bool isNew = DateTime.now().difference(dateAnnonce).inDays < 7;
    String desc = "";
    if(moinsDunJour) {
      desc = "aujourd'hui";
    } else if(moinsDeDeuxJour) {
      desc = "hier";
    } else if(!isNew){
      desc = "${(DateTime.now()).difference(dateAnnonce).inDays~/7} semaines";
    } else if(isNew){
      desc = "${(DateTime.now()).difference(dateAnnonce).inDays} jours";
    }
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(annonceModel: annonceModel)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow : [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? TColors.darkerGrey : TColors.white,
        ),
        child: Column(
          children: [
            TRoundedContainer(
              height: 190,
              padding: const EdgeInsets.all(TSizes.xs),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  TRoundedImage(imageUrl: annonceModel.photo.first.photo, applyImageRadius: true, isNetworkImage: true,),
                  Positioned(
                    top: 5,
                    left: 5,
                    child: TRoundedContainer(
                      radius: TSizes.xs,
                      backgroundColor: Colors.yellow.withOpacity(0.9),
                      padding: const EdgeInsets.symmetric(horizontal: TSizes.xs, vertical: TSizes.xs),
                      child: Text(desc, style: Theme.of(context).textTheme.labelSmall!.apply(color: TColors.black, fontFamily: 'Poppins',fontSizeDelta: -3, fontWeightDelta: -2)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.yellow.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        '${annonceModel.voiture.etat}/10',
                        style: const TextStyle(color: TColors.black, fontWeight: FontWeight.normal, fontSize: 8),
                      ),
                    ),
                  ),
                ],
              )
            ),
             const SizedBox(height: TSizes.spaceBtwItems/2),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TProductTitleText(title: annonceModel.voiture.modele.nomModele, smallSize: true,),
                      const SizedBox(height: TSizes.spaceBtwItems/2),
                      TBrandTitleWithVerifiedIcon(title: annonceModel.voiture.marque.nomMarque),
                    ],
                  ),
                ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Padding(
                  padding: const EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(price: annonceModel.prix.toString()),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: TColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(TSizes.cardRadiusMd),
                      bottomRight: Radius.circular(TSizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                        child: annonceModel.etat == 20
                            ? const Icon(Iconsax.more_circle, color: TColors.white)
                            : (annonceModel.etat == 0
                            ? const Icon(Iconsax.timer, color: TColors.white)
                            : (annonceModel.etat == 5
                              ? const Icon(Iconsax.trash, color: TColors.white)
                              : const Icon(Iconsax.dollar_circle, color: TColors.white)
                            )
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      
      ),
    );
  }
}

