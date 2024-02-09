import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:mada_jeune/commons/widgets/icons/t_circular_icon.dart';
import 'package:mada_jeune/commons/widgets/images/rounded_image.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/features/shop/screens/product_details/widgets/bottom_add_to_card_widget.dart';
import 'package:mada_jeune/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:mada_jeune/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:mada_jeune/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:mada_jeune/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.annonceModel});

  final AnnonceModel annonceModel;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: TBottomAddToCart(annonceModel: annonceModel),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TProductSlider(annonceModel: annonceModel),

            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: <Widget>[
                  const TRatingAndShare(),

                  TProductMetaData(annonceModel: annonceModel),
                  const SizedBox(height: TSizes.spaceBtwSections),


                  TProductAttributes(annonceModel: annonceModel),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(width: double.infinity, child: ElevatedButton(
                      onPressed: () {
                        TLoaders.successSnackBar(title: 'Info', message: 'Vous ne pouvez pas modifier votre publication pour le moment');
                      },
                      child: Text(annonceModel.etat == 20
                        ? 'Booster la publication'
                        : (annonceModel.etat == 0
                          ? 'Modifier ma publication'
                          : 'Mettre dans la corbeille'
                      )))),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  const TSectionHeading(title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ReadMoreText(
                    annonceModel.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Voir plus',
                    trimExpandedText: 'Voir moins',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Nombre de vues(5)', showActionButton: false),
                      IconButton(icon: const Icon(Iconsax.arrow_right_3, size: 18), onPressed: () {})
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Publiee le ', showActionButton: false),
                      Text(annonceModel.dateAnnonce, style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ],
              ),
            )
          ]
        )
      ),
    );
  }
}
