import 'package:flutter/material.dart';

class ProductScrren extends StatelessWidget {
  const ProductScrren({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20) ),clipBehavior: Clip.antiAlias,
        child: const Center(child: Text("Product Screen")));
  }
}