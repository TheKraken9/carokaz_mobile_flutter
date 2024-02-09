import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/screens/add.dart';
import 'package:mada_jeune/screens/favoris.dart';
import 'package:mada_jeune/screens/home.dart';
import 'package:mada_jeune/screens/profile.dart';
import 'package:mada_jeune/screens/search.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller._selectedIndex.value,
        onDestinationSelected: (index) => controller._selectedIndex.value = index,
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Iconsax.search_favorite), label: 'Rechercher'),
          NavigationDestination(icon: Icon(Iconsax.element_plus), label: 'Ajouter'),
          NavigationDestination(icon: Icon(Iconsax.heart), label: 'Favoris'),
          NavigationDestination(icon: Icon(Iconsax.user), label: 'Profil'),
          ],
        ),
      ),
      body: Obx( () => controller.screens[controller._selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> _selectedIndex = 0.obs;
  final screens = [
    const Home(),
    const Search(),
    const Add(),
    const Favoris(),
    const Profile(),
  ];
}
