import 'package:e_commerce_admin_app/controllers/main_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hugeicons/hugeicons.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final MainController mainController = Get.find();
  final ToggleModeController toggleModeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return mainController.isCheckingToken.value
          ? Scaffold(body: Container())
          : Scaffold(
              backgroundColor: toggleModeController.isDarkMode.value
                  ? const Color.fromARGB(255, 31, 31, 31)
                  : const Color(0xffE0E0E0),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Container(
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 190, 190, 190),
                        ),
                        color: toggleModeController.isDarkMode.value
                            ? const Color(0xff141218)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text("SlowKey", style: TextStyle(fontSize: 15)),
                          Divider(color: Colors.grey.shade400, thickness: 1.2),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.person, size: 58),
                                const SizedBox(width: 25),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Chhin Chhairong",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "email@example.com",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.shade400, thickness: 1.2),
                          Expanded(
                            child: NavigationRail(
                              extended: true,
                              backgroundColor:
                                  toggleModeController.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.white,
                              selectedLabelTextStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: toggleModeController.isDarkMode.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              selectedIndex: mainController.selectedIndex.value,
                              onDestinationSelected: mainController.changeIndex,
                              destinations: const [
                                NavigationRailDestination(
                                  icon: Icon(HugeIcons.strokeRoundedHome05),
                                  label: Text("Dashboard"),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(
                                    HugeIcons.strokeRoundedProductLoading,
                                  ),
                                  label: Text("Products"),
                                ),

                                NavigationRailDestination(
                                  icon: Icon(HugeIcons.strokeRoundedArrange),
                                  label: Text("Category"),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(HugeIcons.strokeRoundedBrandfetch),
                                  label: Text("Brand"),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(FontAwesomeIcons.sellcast),
                                  label: Text("Sell"),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.person),
                                  label: Text("User"),
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
                                color: Color.fromARGB(255, 190, 190, 190),
                              ),
                              color: toggleModeController.isDarkMode.value
                                  ? const Color(0xff141218)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 30,
                            ),
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
                                  color: Color.fromARGB(255, 190, 190, 190),
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
