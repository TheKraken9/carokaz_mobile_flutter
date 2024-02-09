import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/features/personalization/screens/address/add_new_address.dart';
import 'package:mada_jeune/features/personalization/screens/address/widgets/single_address.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key, required this.utilisateur, });

  final UtilisateurModel utilisateur;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColors.primary,
        onPressed: () {
          TLoaders.successSnackBar(title: 'Info', message: 'Vous ne pouvez pas ajouter une nouvelle adresse pour le moment');
        },
        child: const Icon(Iconsax.add, color: TColors.white),
      ),
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Mes adresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TSingleAddress(selectedAddress: true, utilisateur: utilisateur,)
            ]
          )
        )
      ),
    );
  }
}
