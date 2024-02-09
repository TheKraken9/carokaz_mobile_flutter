import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.selectedAddress, required this.utilisateur
  });

  final bool selectedAddress;
  final UtilisateurModel utilisateur;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      padding: const EdgeInsets.all(TSizes.md),
      backgroundColor: selectedAddress ? TColors.primary.withOpacity(0.5) : Colors.transparent,
      borderColor: selectedAddress ? Colors.transparent : dark ? TColors.darkerGrey : TColors.grey,
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                ? dark
                  ? TColors.light
                  : TColors.dark
                : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                utilisateur.nom,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: TSizes.sm/2),
              Text(utilisateur.contact, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: TSizes.sm/2),
              Text(utilisateur.adresse, maxLines: 2, softWrap: true),
            ],
          )
        ],
      ),
    );
  }
}
