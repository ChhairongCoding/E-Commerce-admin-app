import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20) ),clipBehavior: Clip.antiAlias,
        child: const Center(child: Text("Home"))),
    );
  }
}
