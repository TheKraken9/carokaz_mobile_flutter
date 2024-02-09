import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/utils/constants/color.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key, this.iconColor = Colors.black, required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: onPressed, icon: Icon(Iconsax.notification, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: TColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white, fontSizeFactor: 0.8)),
              )
          ),
        ),
      ],
    );
  }
}
