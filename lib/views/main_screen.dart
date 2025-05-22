import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.find();
  final ToggleModeController toggleModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mainController.isCheckingToken.value
          ?  Scaffold(body: Container())
          : Scaffold(
              backgroundColor: toggleModeController.isDarkMode.value
                  ? Color.fromARGB(255, 31, 31, 31)
                  : Color(0xffE0E0E0),
              body: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 15,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 200, // fixed width for NavigationRail
                            decoration: BoxDecoration(
                              color: toggleModeController.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ListTile(),
                                Text("Title"),
                                Divider(
                                  color: Colors.grey.shade400,
                                  thickness: 1.2,
                                ),
                                Expanded(
                                  child: NavigationRail(
                                    extended: true,
                                    selectedIndex:
                                        controller.selectedIndex.value,
                                    onDestinationSelected: (index) {
                                      controller.changeIndex(index);
                                    },
                                    destinations: [
                                      NavigationRailDestination(
                                        icon: Icon(Icons.home),
                                        label: Text("Home"),
                                      ),
                                      NavigationRailDestination(
                                        icon: Icon(Icons.dashboard),
                                        label: Text("Dashboard"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(color: Colors.grey, thickness: 1.5),
                          Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: ListTile(
                              title: Row(
                                children: const [
                                  Icon(Icons.logout, size: 28),
                                  SizedBox(width: 25),
                                  Text(
                                    "Sign Out",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                mainController.signOut();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Content Area
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: toggleModeController.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              color: toggleModeController.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 16),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Hello Chhairong,",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    toggleModeController.toggleTheme();
                                  },
                                  icon: toggleModeController.isDarkMode.value
                                      ? const Icon(FontAwesomeIcons.sun)
                                      : const Icon(FontAwesomeIcons.moon),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: toggleModeController.isDarkMode.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                color: toggleModeController.isDarkMode.value
                                    ? const Color(0xff141218)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: mainController
                                  .listPage[mainController.selectedIndex.value],
                            ),
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
