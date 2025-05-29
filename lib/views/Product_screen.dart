import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final RxString isSelect = "value 1".obs;

  final List<String> listDropDown = [
    "value 1",
    "Value 2",
    "Value 3",
    "Value 4",
    "Value 5",
  ].obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Products", style: TextStyle(fontSize: 30)),
                Row(
                  spacing: 10,
                  children: [
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedFileExport),
                            SizedBox(width: 10),
                            Text("Export"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedPrinter),
                            SizedBox(width: 10),
                            Text("Print"),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          border: Border.all(color: Colors.white38),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedAdd01),
                            SizedBox(width: 10),
                            Text("Create Product"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Search anything...",
                      prefixIcon: Icon(HugeIcons.strokeRoundedSearch01),
                    ),
                  ),
                ),

                Obx(
                  () => Row(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            icon: Icon(HugeIcons.strokeRoundedFilterEdit),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: isSelect.value,

                              items: listDropDown.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  isSelect.value = newValue;
                                }
                              },
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Divider(height: 1, thickness: 1.1),
          ],
        ),
      ),
    );
  }
}
