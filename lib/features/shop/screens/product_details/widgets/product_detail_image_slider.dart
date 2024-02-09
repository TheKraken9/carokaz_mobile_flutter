import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:mada_jeune/commons/widgets/icons/t_circular_icon.dart';
import 'package:mada_jeune/commons/widgets/images/rounded_image.dart';
import 'package:mada_jeune/data/models/annonce/annonce_model.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';
import 'package:mada_jeune/utils/constants/sizes.dart';
import 'package:mada_jeune/utils/helpers/helper_functions.dart';

class TProductSlider extends StatefulWidget {
  const TProductSlider({
    super.key, required this.annonceModel,
  });

  final AnnonceModel annonceModel;

  @override
  _TProductSliderState createState() => _TProductSliderState();
}

class _TProductSliderState extends State<TProductSlider> {
  String selectedImage = "";

  @override
  void initState() {
    super.initState();
    selectedImage = widget.annonceModel.photo.first.photo;
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgeWidget(
        child: Container(
            color: dark ? TColors.darkerGrey : TColors.light,
            child: Stack(
                children: [
                  SizedBox(height: 400, child: Padding(
                    padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                    child: Center(child: Image(image: NetworkImage(selectedImage),)),
                  )
                  ),
                  Positioned(
                    right: 0,
                    bottom: 30,
                    left: TSizes.defaultSpace,
                    child: SizedBox(
                      height: 80,
                      child: ListView.separated(
                        itemCount: widget.annonceModel.photo.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        physics: const AlwaysScrollableScrollPhysics(),
                        separatorBuilder: (_,__) => const SizedBox(width: TSizes.spaceBtwItems),
                        itemBuilder: (_, index) =>  TRoundedImage(
                            width: 80,
                            backgroundColor: dark ? TColors.dark : TColors.white,
                            border: Border.all(color: TColors.primary),
                            padding: const EdgeInsets.all(TSizes.sm),
                            imageUrl: widget.annonceModel.photo[index].photo,
                            isNetworkImage: true,
                          onPressed: () {
                            if (kDebugMode) {
                              print('image clicked');
                            }
                            //make the image at the index the main image
                            setState(() {
                              selectedImage = widget.annonceModel.photo[index].photo;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const TAppBar(
                    showBackArrow: true,
                    actions: [
                      TCircularicon(icon: Iconsax.car, color: Colors.red),
                    ],
                  )
                ]
            )
        )
    );
  }
}