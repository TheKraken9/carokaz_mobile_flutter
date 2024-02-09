import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/search_container.dart';
import 'package:mada_jeune/commons/widgets/layout/grid_layout.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/services/annonce/annonce_service.dart';
import 'package:mada_jeune/features/shop/screens/home/widget/home_appbar.dart';
import 'package:mada_jeune/features/shop/screens/home/widget/home_categories.dart';
import 'package:mada_jeune/features/shop/screens/home/widget/promo_slider.dart';
import 'package:mada_jeune/features/shop/screens/wishlist/wishlist.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AnnonceService get annonceService => GetIt.I<AnnonceService>();
  late APIResponse<List<AnnonceModel>> _apiResponse = APIResponse<List<AnnonceModel>>(data: []);
  String? nomUtilisateur;

  @override
  void initState() {
    _fetchAnnonces();
    super.initState();
  }

  _fetchAnnonces() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUtilisateur');
    if (kDebugMode) {
      print(idUser);
    }
    _apiResponse = await annonceService.getAllAnnonce(idUser);
    setState(() {
      _apiResponse = _apiResponse;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(_apiResponse.data!.isEmpty) {
      return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      THomeAppBar(nomUtilisateur: "Vous n\'avez pas d\'annonce"),
                      SizedBox(height: TSizes.spaceBtwSections),

                      TSearchContainer(text: 'Rechercher une voiture'),
                      SizedBox(height: TSizes.spaceBtwSections),

                      Padding(
                        padding: EdgeInsets.only(left: TSizes.defaultSpace),
                        child: Column(
                          children: [
                            TSectionHeading(title: 'Les plus vendues', showActionButton: false, textColor: Colors.white,),
                            SizedBox(height: TSizes.spaceBtwSections),

                            THomeCategories()
                          ],
                        ),
                      ),
                      SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      const TPromoSlider(banners: [TImages.audi, TImages.bmw, TImages.renault, TImages.peugeot],),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      TSectionHeading(title: 'Mes ventes', onPressed: () => Get.to(const FavoriteScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                )
              ],
            ),
          )
      );
    } else {
      nomUtilisateur = "${_apiResponse.data![0].utilisateur!.nom} ${_apiResponse.data![0].utilisateur!.prenom}";

      return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                TPrimaryHeaderContainer(
                  child: Column(
                    children: [
                      THomeAppBar(nomUtilisateur: nomUtilisateur!),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      const TSearchContainer(text: 'Rechercher une voiture'),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      const Padding(
                        padding: EdgeInsets.only(left: TSizes.defaultSpace),
                        child: Column(
                          children: [
                            TSectionHeading(title: 'Les plus vendues', showActionButton: false, textColor: Colors.white,),
                            SizedBox(height: TSizes.spaceBtwSections),

                            THomeCategories()
                          ],
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: Column(
                    children: [
                      const TPromoSlider(banners: [TImages.audi, TImages.bmw, TImages.renault, TImages.peugeot],),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      TSectionHeading(title: 'Mes ventes', onPressed: () => Get.to(const FavoriteScreen())),
                      const SizedBox(height: TSizes.spaceBtwItems),

                      TGridLayout(
                        itemCount: _apiResponse.data!.length >= 2 ? 2 : _apiResponse.data!.length,
                        itemBuilder: (_, index) => TProductCardVertical(annonceModel: _apiResponse.data![index],),
                      )],
                  ),
                )
              ],
            ),
          )
      );
    }

  }

}





