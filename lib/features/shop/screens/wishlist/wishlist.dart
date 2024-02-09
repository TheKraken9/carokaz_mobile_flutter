import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/icons/t_circular_icon.dart';
import 'package:mada_jeune/commons/widgets/layout/grid_layout.dart';
import 'package:mada_jeune/commons/widgets/products/product_cards/product_card_vertical.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/data/models/api_response.dart';
import 'package:mada_jeune/data/services/annonce/annonce_service.dart';
import 'package:mada_jeune/features/personalization/screens/address/add_new_address.dart';
import 'package:mada_jeune/features/shop/screens/home/home.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  AnnonceService get annonceService => GetIt.I<AnnonceService>();
  late APIResponse<List<AnnonceModel>> _apiResponse = APIResponse<List<AnnonceModel>>(data: []);

  @override
  void initState() {
    _fetchAnnonces();
    super.initState();
  }

  _fetchAnnonces() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUtilisateur');
    if(idUser != null){
      _apiResponse = await annonceService.getAllAnnonce(idUser);
      if (kDebugMode) {
        print(_apiResponse.data!.length);
      }
    }
    setState(() {
      _apiResponse = _apiResponse;
    });
  }


  @override
  Widget build(BuildContext context) {

    if(_apiResponse.data!.isEmpty) {
      return Center(
        child: Lottie.asset('assets/animations/Animation9.json'),
      );
    }

    return Scaffold(
      appBar: TAppBar(
        title: Text('Mes Ventes', style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          TCircularicon(icon: Iconsax.add, onPressed: () => Get.to(const AddNewAddressScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              TGridLayout(
                  itemCount: _apiResponse.data!.length,
                  itemBuilder: (_, index) => TProductCardVertical(annonceModel: _apiResponse.data![index],)
              )
            ]
          )
        )
      ),
    );
  }
}
