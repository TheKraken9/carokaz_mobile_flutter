import 'package:flutter/material.dart';

class Favoris extends StatelessWidget {
  const Favoris({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Mes favoris'),
      ),
      body: const Center(
        child: Text('Page One'),
      ),
    );
  }
}
