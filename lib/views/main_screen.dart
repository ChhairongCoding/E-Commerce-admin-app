import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController controller = Get.find();
  final ToggleModeController toggleModeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.isCheckingToken.value
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
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
                            width: 200,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: toggleModeController.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.yellow,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: NavigationRail(
                              extended: true,
                              selectedIndex: controller.selectedIndex.value,
                              onDestinationSelected: (index) {
                                controller.changeIndex(index);
                              },
                              leading: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("SlowKey"),
                              ),
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
                              trailing: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.toNamed("/signIn");
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text("Sign Out"),
                                  ),
                                ),
                              ),
                              useIndicator: true,
                            ),
                          ),

                          Expanded(
                            child: Column(
                              spacing: 15,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          toggleModeController.isDarkMode.value
                                          ? const Color(0xff141218)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 16,
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Hello Chhairong,",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          spacing: 20,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                toggleModeController
                                                    .toggleTheme();
                                              },
                                              icon:
                                                  toggleModeController
                                                      .isDarkMode
                                                      .value
                                                  ? Icon(FontAwesomeIcons.sun)
                                                  : Icon(FontAwesomeIcons.moon),
                                            ),
                                            const Icon(Icons.settings),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            toggleModeController
                                                .isDarkMode
                                                .value
                                            ? const Color(0xff141218)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      child:
                                          controller.listPage[controller
                                              .selectedIndex
                                              .value],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
