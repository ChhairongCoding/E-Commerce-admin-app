import 'package:e_commerce_admin_app/controllers/category_controller.dart';
import 'package:e_commerce_admin_app/controllers/product_controller.dart';
import 'package:e_commerce_admin_app/controllers/toggle_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ToggleModeController toggleModeController = Get.find();
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
              ),
              const SizedBox(height: 24),

              // Summary Cards
              _buildSummaryCards(size),

              const SizedBox(height: 32),

              // Analytics Section
              Text(
                "Analytics",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
              ),
              const SizedBox(height: 16),
              _buildAnalyticsSection(size, context),
            ],
          ),
        ),
      ),
    );
  }

  // Summary Cards Section
  Widget _buildSummaryCards(Size size) {
    return Obx(() {
      final isDark = toggleModeController.isDarkMode.value;
      final categoriesRes = categoryController.categoryRes();
      final productsRes = productController.productRes();

      final cardData = [
        {
          'title': 'Categories',
          'subtitle': 'Total',
          'value': '${categoriesRes.data.length}',
          'icon': HugeIcons.strokeRoundedFolder02,
        },
        {
          'title': 'Products',
          'subtitle': 'Available',
          'value': '${productsRes.data?.products.length ?? 0}',
          'icon': HugeIcons.strokeRoundedShoppingBag02,
        },
        {
          'title': 'Sales',
          'subtitle': 'This Month',
          'value': '\$12,450',
          'icon': HugeIcons.strokeRoundedChartLineData03,
        },
      ];

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: size.width < 600 ? 1.5 : 2,
        ),
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          final data = cardData[index];
          return _buildCard(
            context,
            size,
            data['title'] as String,
            data['subtitle'] as String,
            data['value'] as String,
            data['icon'] as IconData,
            isDark,
          );
        },
      );
    });
  }

  // Individual Card Widget
  Widget _buildCard(
    BuildContext context,
    Size size,
    String title,
    String subtitle,
    String value,
    IconData icon,
    bool isDark,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.grey[800]!, Colors.grey[900]!]
                : [Colors.white, Colors.grey[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: size.width < 600 ? 20 : 24,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: size.width < 600 ? 12 : 14,
                    color: isDark ? Colors.white70 : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: size.width < 600 ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: size.width * 0.06,
                color: isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Analytics Section with Charts
  Widget _buildAnalyticsSection(Size size, BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // Line Chart
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sales Trend",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: 5,
                          minY: 0,
                          maxY: 4,
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            horizontalInterval: 1,
                          ),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 32,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan',
                                    'Feb',
                                    'Mar',
                                    'Apr',
                                    'May',
                                    'Jun'
                                  ];
                                  return Text(
                                    value.toInt() < months.length
                                        ? months[value.toInt()]
                                        : '',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) => Text(
                                  '${value.toInt()}k',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            rightTitles:
                                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles:
                                AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              isCurved: true,
                              color: Colors.blueAccent,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blueAccent.withOpacity(0.2),
                              ),
                              spots: const [
                                FlSpot(0, 1),
                                FlSpot(1, 1.5),
                                FlSpot(2, 1.2),
                                FlSpot(3, 2.5),
                                FlSpot(4, 3.2),
                                FlSpot(5, 2.8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Pie Chart
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Status",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 60,
                              color: Colors.green,
                              title: '60%\nCompleted',
                              radius: 80,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: 25,
                              color: Colors.orange,
                              title: '25%\nPending',
                              radius: 70,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              value: 15,
                              color: Colors.redAccent,
                              title: '15%\nCancelled',
                              radius: 60,
                              titleStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                          centerSpaceRadius: 50,
                          sectionsSpace: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}