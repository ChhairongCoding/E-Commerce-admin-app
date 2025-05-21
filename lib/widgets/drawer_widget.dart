import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("SlowKey")),
          ListTile(
            leading: Icon(Icons.settings),
            onTap: () {
              Get.toNamed("/toggleMode");
            },
            title: Text("Setting"),
          ),
        ],
      ),
    );
  }
}
