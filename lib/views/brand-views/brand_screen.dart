import 'package:e_commerce_admin_app/controllers/brand_controller.dart';
import 'package:e_commerce_admin_app/views/brand-views/main_brand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class BrandScreen extends StatelessWidget {
  BrandScreen({super.key});
  final BrandController brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Brands", style: TextStyle(fontSize: 30)),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Export functionality here
                      },
                      icon: Icon(HugeIcons.strokeRoundedFileExport),
                      label: Text("Export"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Print functionality here
                      },
                      icon: Icon(HugeIcons.strokeRoundedPrinter),
                      label: Text("Print"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: Icon(HugeIcons.strokeRoundedAdd01),
                      label: Text("Create Brand"),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        side: BorderSide(color: Colors.white38),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Get.find<MainBrandController>().toggleSwitch(1);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() {
                final headers = brandController.headerTable;
                final brands = brandController.brandRes.value.data;

                return DataTable(
                  columnSpacing: 210,
                  columns: headers
                      .map(
                        (header) => DataColumn(
                          label: Text(
                            header,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  rows: List.generate(brands.length, (rowIndex) {
                    final brand = brands[rowIndex];

                    return DataRow(
                      cells: [
                        DataCell(Text("ID ${rowIndex + 1}")),
                        DataCell(Text(brand.name ?? 'N/A')),
                        DataCell(Text(brand.totalProducts.toString())),
                        DataCell(
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  brandController.onEditBrandTap(brand.id!);

                                },
                                label: Icon(HugeIcons.strokeRoundedEdit01),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await brandController.removeBrand(
                                    brand.id.toString(),
                                  );
                                  Get.back();
                                },
                                label: Icon(HugeIcons.strokeRoundedDelete01),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
