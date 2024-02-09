import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/images/circular_image.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/features/personalization/screens/settings/profile/widgets/profile_menu.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.utilisateur});

  final UtilisateurModel utilisateur;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Mon profil'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
               SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const TCircularImage(image: TImages.user, width: 80, height: 80),
                      TextButton(onPressed: (){}, child: const Text('Changer ma photo de profil')),
                    ],
                  ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems/2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(title: 'Informations personnelles', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'Nom', value: utilisateur.nom, onPressed: () {},),
              TProfileMenu(title: 'Prenom', value: utilisateur.prenom, onPressed: () {},),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(title: 'Informations de contact', showActionButton: false,),
              const SizedBox(height: TSizes.spaceBtwItems),

              TProfileMenu(title: 'ID', value: utilisateur.idUtilisateur, icon: Iconsax.copy, onPressed: () {},),
              TProfileMenu(title: 'Email', value: utilisateur.mail, onPressed: () {},),
              TProfileMenu(title: 'Telephone', value: utilisateur.contact, onPressed: () {},),
              TProfileMenu(title: 'Adresse', value: utilisateur.adresse, onPressed: () {},),
              TProfileMenu(title: 'Ville', value: utilisateur.ville.nomVille, onPressed: () {},),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: (){},
                  child: const Text('Desactiver mon compte', style: TextStyle(color: Colors.red),),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}

