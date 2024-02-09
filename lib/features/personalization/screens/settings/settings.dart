import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:mada_jeune/commons/widgets/list_tiles/settings_menu_tiles.dart';
import 'package:mada_jeune/commons/widgets/list_tiles/user_profile_tile.dart';
import 'package:mada_jeune/commons/widgets/loaders/loaders.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/models/utilisateur/utilisateur_model.dart';
import 'package:mada_jeune/data/services/utilisateur/utilisateur_service.dart';
import 'package:mada_jeune/features/personalization/screens/address/address.dart';
import 'package:mada_jeune/features/personalization/screens/settings/profile/profile.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final storage = const FlutterSecureStorage();

  late SharedPreferences _sharedPreferences;
  late String _idUtilisateur;
  late String _nomUtilisateur;
  UtilisateurService get utilisateurService => GetIt.I<UtilisateurService>();

  late APIResponse<UtilisateurModel> _apiResponse = APIResponse<UtilisateurModel>();

  @override
  void initState() {
    _fetchUtilisateur();
    super.initState();
  }

  _fetchUtilisateur() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
    _idUtilisateur = _sharedPreferences.getString('idUtilisateur')!;
    _nomUtilisateur = _sharedPreferences.getString('email')!;
    });
    _apiResponse = (await utilisateurService.getUtilisateur(_idUtilisateur));
    setState(() {
      _apiResponse = _apiResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_apiResponse.data?.idUtilisateur == null) {
      return Center(
        child: Lottie.asset('assets/animations/Animation9.json'),// Afficher un indicateur de chargement si la liste est vide
      );
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:[
            TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    TAppBar(
                      title: Text('Profile', style: Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))
                    ),
                      TUserProfileTile(onPressed: () => Get.to(() => ProfileScreen(utilisateur: _apiResponse.data!)), email: _apiResponse.data!.mail,),
                      const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
            ),

            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TSectionHeading(title: 'Parametres', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'Address',
                    subtitle: 'Lieu de rendez-vous',
                    onTap: () => Get.to(() => UserAddressScreen(utilisateur: _apiResponse.data!)),
                  ),
                  TSettingsMenuTile(icon: Iconsax.call, title: 'Contact', subtitle: 'Si on veut me contacter', onTap: (){ TLoaders.successSnackBar(title: 'Contact', message: 'Vous ne pouvez pas ajouter d\'autres contact pour le moment'); },),
                  TSettingsMenuTile(icon: Iconsax.money, title: 'Ventes', subtitle: 'Liste de mes ventes', onTap: () => {
                    Get.toNamed('/ventes')
                  },),
                  TSettingsMenuTile(icon: Iconsax.notification, title: 'Notifications', subtitle: 'Quoi de neuf', onTap: (){ TLoaders.successSnackBar(title: 'Notifications', message: 'Vos ne pouvez pas voir vos notifications pour le moment'); },),
                  TSettingsMenuTile(icon: Iconsax.shopping_bag, title: 'Benefices', subtitle: 'Mes benefices', onTap: (){ TLoaders.successSnackBar(title: 'Benefices', message: 'Vous ne pouvez pas voir vos benefices pour le moment'); },),

                  const SizedBox(height: TSizes.spaceBtwSections),
                  const TSectionHeading(title: 'Plus', showActionButton: false,),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  TSettingsMenuTile(
                    icon: Iconsax.add,
                    title: 'Ajout',
                    subtitle: 'Ajouter une annonce',
                    onTap: (){},
                    trailing: Switch(value: true, onChanged: (value){
                      TLoaders.successSnackBar(title: 'Ajout annonce', message: 'Cette fonctionnalité ne peut pas être changée pour le moment');
                    },),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Recevoir des notifications',
                    onTap: (){},
                    trailing: Switch(value: true, onChanged: (value){
                      TLoaders.successSnackBar(title: 'Notification', message: 'Cette fonctionnalité ne peut pas être changée pour le moment');
                    },),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.user,
                    title: 'Discussions',
                    subtitle: 'statut de discussion',
                    onTap: (){},
                    trailing: Switch(value: true, onChanged: (value){
                      TLoaders.successSnackBar(title: 'Discussion', message: 'Cette fonctionnalité ne peut pas être changée pour le moment');
                    },),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Deconnexion'),
                              content: const Text('Êtes-vous sûr de vouloir continuer ?'),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Annuler'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Ferme le dialogue
                                  },
                                ),
                                TextButton(
                                  child: const Text('Confirmer'),
                                  onPressed: () async {
                                    Navigator.of(context).pop(); // Ferme le dialogue
                                    await storage.deleteAll();
                                    _sharedPreferences = await SharedPreferences.getInstance();
                                    _sharedPreferences.clear();
                                    TLoaders.successSnackBar(title: 'Deconnexion', message: 'Vous avez ete deconnecte avec succes');
                                    Get.offAllNamed('/login');
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Deconnexion'),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ]
        )
      )
    );
  }
}
