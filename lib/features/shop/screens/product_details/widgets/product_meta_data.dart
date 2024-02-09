import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/commons/widgets/images/circular_image.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_price_text.dart';
import 'package:mada_jeune/commons/widgets/text/product_title_text.dart';
import 'package:mada_jeune/commons/widgets/text/t_brand_title_text_with_verified_icon.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/enums.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, required this.annonceModel});

  final AnnonceModel annonceModel;

  @override
  Widget build(BuildContext context) {
    String desc = "";
    final dateAnnonce = DateTime.parse(annonceModel.dateAnnonce);
    final today = DateTime.now();
    final dateToday = DateTime(today.year, today.month, today.day);
    final bool moinsDunJour = dateToday.difference(dateAnnonce).inDays == 0;
    final bool moinsDeDeuxJour = dateToday.difference(dateAnnonce).inDays == 1;
    final bool isNew = DateTime.now().difference(dateAnnonce).inDays < 7;
    if(moinsDunJour) {
      desc = "aujourd'hui";
    } else if(moinsDeDeuxJour) {
      desc = "hier";
    } else if(!isNew){
      desc = "${(DateTime.now()).difference(dateAnnonce).inDays~/7} semaines";
    } else if(isNew){
      desc = "${(DateTime.now()).difference(dateAnnonce).inDays} jours";
    }
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children:[
            TRoundedContainer(
                radius: TSizes.sm,
                backgroundColor: Colors.yellow.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.sm),
                child: Text(desc, style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black))
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            //Text(annonceModel.prix.toString(), style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            const SizedBox(width: TSizes.spaceBtwItems),
            TProductPriceText(price: annonceModel.prix.toString())
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/1.5),

        TProductTitleText(title: annonceModel.voiture.modele.nomModele),
        const SizedBox(height: TSizes.spaceBtwItems/1.5),

        Row(
          children: [
            const TProductTitleText(title: 'Status : '),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(annonceModel.etat == 20
                ? 'En vente'
                : (annonceModel.etat == 0
                  ? 'En attente'
                  : (annonceModel.etat == 5
                    ? 'Supprimee'
                    : 'Vendue')
            ),
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems/1.5),

        Row(
          children: [
            TCircularImage(
              image: TImages.lightLogo,
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black,
            ),

            TBrandTitleWithVerifiedIcon(title: annonceModel.voiture.marque.nomMarque, brandTextSize: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
