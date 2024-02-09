import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/features/personalization/screens/address/add_new_address.dart';
import 'package:mada_jeune/features/personalization/screens/address/loadingScreenAddNewAnnonce.dart';
import 'package:mada_jeune/features/personalization/screens/settings/settings.dart';
import 'package:mada_jeune/features/shop/screens/home/home.dart';
import 'package:mada_jeune/features/shop/screens/store/store.dart';
import 'package:mada_jeune/features/shop/screens/wishlist/wishlist.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
            height: 80,
            elevation: 0,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.selectedIndex.value = index,
            backgroundColor: dark ? Colors.black : Colors.white,
            indicatorColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Accueil',),
              NavigationDestination(icon: Icon(Iconsax.search_normal), label: 'Rechercher',),
              NavigationDestination(icon: Icon(Iconsax.add), label: 'Ajouter'),
              NavigationDestination(icon: Icon(Iconsax.money), label: 'Mes ventes'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profil'),
            ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const StoreScreen(),
    const LoadingScreenAddNewAnnonce(),
    const FavoriteScreen(),
    const SettingsScreen()
  ];
}