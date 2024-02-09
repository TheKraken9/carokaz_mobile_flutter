import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mada_jeune/Animation/simulateLoading.dart';
import 'package:mada_jeune/features/personalization/screens/address/add_new_address.dart';

class LoadingScreenAddNewAnnonce extends StatelessWidget {
  const LoadingScreenAddNewAnnonce({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: simulateLoading(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Lottie.asset('assets/animations/Animation9.json'), // Remplacez par votre animation Lottie
            ),
          );
        } else {
          return const AddNewAddressScreen();
        }
      },
    );
  }
}