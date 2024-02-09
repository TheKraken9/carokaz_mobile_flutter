import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/images/circular_image.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed, required this.email,
  });

  final String email;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const TCircularImage(
        image: TImages.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(email, style: Theme
          .of(context)
          .textTheme
          .headlineSmall!
          .apply(color: TColors.white)),
      subtitle: Text('Voir mon profil', style: Theme
          .of(context)
          .textTheme
          .bodyMedium!
          .apply(color: TColors.white)),
      trailing: IconButton(onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: TColors.white)),
    );
  }
}