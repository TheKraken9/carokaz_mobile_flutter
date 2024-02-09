import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/chips/choice_chip.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_price_text.dart';
import 'package:mada_jeune/commons/widgets/text/product_title_text.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({Key? key, required this.annonceModel}) : super(key: key);

  final AnnonceModel annonceModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  const TSectionHeading(title: 'Details', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const TProductTitleText(title: 'Model : ', smallSize: true),
                          Text('${annonceModel.voiture.modele.nomModele} ${annonceModel.voiture.marque.nomMarque}', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Categorie : ', smallSize: true),
                          Text(annonceModel.voiture.modele.categorie.nomCategorie, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Energie : ', smallSize: true),
                          Text(annonceModel.voiture.energie.nomEnergie, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Boite : ', smallSize: true),
                          Text(annonceModel.voiture.boite.nomBoite, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Consommation : ', smallSize: true),
                          Text(annonceModel.voiture.consommation.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Kilometrage : ', smallSize: true),
                          Text(annonceModel.voiture.kilometrage.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Row(
                        children: [
                          const TProductTitleText(title: 'Etat sur 10 : ', smallSize: true),
                          Text(annonceModel.voiture.etat.toString(), style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Couleur', showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: annonceModel.voiture.couleur.nomCouleur, selected: false, onSelected: (value){},),
              ]
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Nombre de places', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: annonceModel.voiture.place.valeur.toString(), selected: false, onSelected: (value){},),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: 'Nombre de porte', showActionButton: false,),
            const SizedBox(height: TSizes.spaceBtwItems/2),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(text: annonceModel.voiture.porte.valeur.toString(), selected: false, onSelected: (value){},),
              ],
            )
          ],
        )
      ],
    );
  }
}