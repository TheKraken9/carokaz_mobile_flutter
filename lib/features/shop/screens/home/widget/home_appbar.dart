import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mada_jeune/commons/widgets/appbar/appbar.dart';
import 'package:mada_jeune/commons/widgets/products/cart/cart_menu_icon.dart';
import 'package:mada_jeune/utils/constants/color.dart';
import 'package:mada_jeune/utils/constants/text_strings.dart';

class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key, required this.nomUtilisateur,
  });

  final String nomUtilisateur;

  triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 100,
        channelKey: 'basic_channel',
        title: 'Notification',
        body: 'Vous avez un nouveau message',
        //bigPicture: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
        notificationLayout: NotificationLayout.BigPicture,
        //largeIcon: 'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nomUtilisateur, style: Theme.of(context).textTheme.titleMedium!.apply(color: TColors.white)),
          Text(TTexts.homeAppbarSubtitle, style: Theme.of(context).textTheme.labelSmall!.apply(color: TColors.white)),
        ],
      ),
      actions: [
        TCartCounterIcon(
          onPressed: triggerNotification,
          iconColor: TColors.white,
        )
      ],
    );
  }
}