import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/icons/t_circular_icon.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/data/services/annonce/annonce_service.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TBottomAddToCart extends StatelessWidget {
  const TBottomAddToCart({super.key, required this.annonceModel});

  final AnnonceModel annonceModel;

  @override
  Widget build(BuildContext context) {
    final AnnonceService annonceService = AnnonceService();
    final dark = THelperFunctions.isDarkMode(context);
    if (kDebugMode) {
      print(annonceModel.etat);
      print(annonceModel.idAnnonce);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace/2),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                if(annonceModel.etat == 20) {
                  TLoaders.successSnackBar(title: 'Info', message: 'Modification en cours');
                  annonceService.updateEtatAnnonce(annonceModel.idAnnonce);
                  Get.offAllNamed('/home');
                }else if(annonceModel.etat == 0) {
                  TLoaders.successSnackBar(title: 'Suppression', message: 'Modification en cours');
                  annonceService.deleteAnnonce(annonceModel.idAnnonce);
                  Get.offAllNamed('/home');
                }else if(annonceModel.etat == 5) {
                  TLoaders.successSnackBar(title: 'Remise en vente', message: 'Modification en cours');
                  annonceService.reUpdateEtatAnnonce(annonceModel.idAnnonce);
                  Get.offAllNamed('/home');
                }else {
                  TLoaders.successSnackBar(title: 'Suppression', message: 'Non disponible');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(TSizes.md),
                backgroundColor: TColors.black,
                side: const BorderSide(color: TColors.black),
             ),
              child: Text(annonceModel.etat == 20
                  ? 'Marquer comme vendue'
                  : (annonceModel.etat == 0
                    ? 'Annuler ma publication'
                    : (annonceModel.etat == 5
                    ? 'Remettre en vente'
                    : 'Mettre dans la corbeille'))),
          ),
        ],
      ),
    );
  }
}
