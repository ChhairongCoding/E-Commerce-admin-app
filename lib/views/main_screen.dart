import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isCheckingToken.value
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      width: double.infinity,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SlowKey Admin Panel",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff012B43),
                            ),
                          ),
                          Icon(Icons.settings, color: Color(0xff012B43)),
                        ],
                      ),
                    ),
                
                    // 🔷 BODY SECTION WITH SIDEBAR + CONTENT
                    Expanded(
                      child: Row(
                        children: [
                          NavigationRail(
                            selectedIndex: controller.selectedIndex.value,
                            onDestinationSelected: (index) {
                              controller.changeIndex(index);
                            },
                            destinations: const [
                              NavigationRailDestination(
                                icon: Icon(Icons.home),
                                label: Text("Home"),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.dashboard),
                                label: Text("Dashboard"),
                              ),
                            ],
                            minWidth: 120,
                            useIndicator: true,
                          ),
                          Expanded(
                            child: controller
                                .listPage[controller.selectedIndex.value],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
