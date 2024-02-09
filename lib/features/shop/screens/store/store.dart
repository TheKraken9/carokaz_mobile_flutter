import 'package:flutter/material.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/appbar/tabbar.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/containers/search_container.dart';
import 'package:mada_jeune/commons/widgets/layout/grid_layout.dart';
import 'package:mada_jeune/commons/widgets/products/cart/cart_menu_icon.dart';
import 'package:mada_jeune/commons/widgets/brands/brand_card.dart';
import 'package:mada_jeune/commons/widgets/text/section_heading.dart';
import 'package:mada_jeune/features/shop/screens/store/widgets/category_tab.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: TAppBar(
          title: Text('Rechercher une voiture', style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            TCartCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(headerSliverBuilder: (_, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              backgroundColor: THelperFunctions.isDarkMode(context) ? TColors.black : TColors.white,
              expandedHeight: 440,
      
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children:  [
                    const SizedBox(height: TSizes.spaceBtwItems),
                    const TSearchContainer(text: '', showBorder: true,showBackground: false,padding: EdgeInsets.zero,),
                    const SizedBox(height: TSizes.spaceBtwSections),
      
                    TSectionHeading(title: 'Les plus vendues', onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems/1.5),
      
                    TGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                      return const TBrandCard(showBorder:false);
                    }
                    )
                  ],
                )
              ),
              bottom: const TTabBar(
                tabs: [
                  Tab(text: 'Toutes'),
                  Tab(text: 'Audi'),
                  Tab(text: 'BMW'),
                  Tab(text: 'Mercedes'),
                  Tab(text: 'Toyota'),
                  Tab(text: 'Volkswagen'),
                ],
              )
            ),
          ];
        },body: const TabBarView(
          children: [
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
            TCategoryTab(),
          ]
        )
        ),
      ),
    );
  }
}



