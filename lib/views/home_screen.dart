import 'package:e_commerce_admin_app/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      drawer: DrawerWidget(),
      body: const Center(child: Text("Home")),
    );
  }
}
