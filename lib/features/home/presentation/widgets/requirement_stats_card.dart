import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fuoday/core/utils/app_responsive.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:fuoday/commons/widgets/k_text.dart';
import 'package:fuoday/core/themes/app_colors.dart';

class RequirementStatsCard extends StatelessWidget {
  final Map<String, double> dataMap;
  final Map<String, Color> colorMap;

  const RequirementStatsCard({
    super.key,
    required this.dataMap,
    required this.colorMap,
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final totalJobs = dataMap.values.fold<double>(0, (a, b) => a + b).toInt();
    final isTablet = AppResponsive.isTablet(context);
    final isLandscape = AppResponsive.isLandscape(context);

    // Scale factor for adaptive UI
    final scale = screenWidth / 375; // 375 is base iPhone width from Figma

    return Container(
      width: screenWidth * 0.87, // ≈ 327 from 375
      height: isTablet
          ? (isLandscape ? screenHeight * 1 : screenHeight * 0.55)
          : screenHeight * 0.45, // adaptive height
      padding: EdgeInsets.all(18 * scale),
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.8 * scale,
          color:
              theme.textTheme.bodyLarge?.color?.withOpacity(0.3) ??
                    AppColors.greyColor
                ..withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(8 * scale),
        color: theme.secondaryHeaderColor, //AppColors.secondaryColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KText(
                text: "Target Status",
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                //color: AppColors.titleColor,
              ),
              // InkWell(
              //   onTap: () {
              //     // TODO: navigate to full screen
              //   },
              //   child: Row(
              //     children: [
              //       KText(
              //         text: "See all",
              //         fontWeight: FontWeight.w500,
              //         fontSize: 16.sp,
              //         color: theme
              //             .inputDecorationTheme
              //             .focusedBorder
              //             ?.borderSide
              //             .color, //subTitleColor
              //       ),
              //       Icon(
              //         Icons.arrow_forward_ios,
              //         size: 16.sp,
              //         color: theme
              //             .textTheme
              //             .headlineLarge
              //             ?.color, //AppColors.titleColor,
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 16 * scale),

          // Pie chart
          Center(
            child: SizedBox(
              width: isTablet
                  ? (isLandscape ? screenHeight * 0.4 : screenHeight * 0.3)
                  : screenWidth * 0.4,
              height: isTablet
                  ? (isLandscape ? screenHeight * 0.4 : screenHeight * 0.3)
                  : screenWidth * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(
                    dataMap: dataMap,
                    colorList: colorMap.values.toList(),
                    chartType: ChartType.ring,
                    ringStrokeWidth: isTablet
                        ? (isLandscape ? 10 * scale : 17 * scale)
                        : 20 * scale,
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                    ),
                    legendOptions: const LegendOptions(showLegends: false),
                    chartLegendSpacing: 12 * scale,
                  ),

                  // Inner circle
                  Container(
                    width: isTablet
                        ? (isLandscape
                              ? screenHeight * 0.25
                              : screenHeight * 0.18)
                        : screenWidth * 0.22,
                    height: isTablet
                        ? (isLandscape
                              ? screenHeight * 0.25
                              : screenHeight * 0.18)
                        : screenWidth * 0.22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? theme.textTheme.bodyLarge?.color
                          : AppColors.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30 * scale,
                          offset: Offset(0, 4 * scale),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KText(
                          text: totalJobs.toString(),
                          fontWeight: FontWeight.w700,
                          fontSize: isTablet
                              ? (isLandscape ? 12 * scale : 14 * scale)
                              : 14 * scale,
                          // color: AppColors.titleColor,
                        ),
                        SizedBox(height: 2 * scale),
                        KText(
                          text: "Total Target",
                          fontWeight: FontWeight.w500,
                          fontSize: isTablet
                              ? (isLandscape ? 8 * scale : 10 * scale)
                              : 10 * scale,
                          color: isDark
                              ? AppColors.secondaryColor
                              : AppColors.subTitleColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16 * scale),

          //  Legend section
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: dataMap.entries.map((entry) {
                final label = entry.key;
                final value = entry.value.toInt();
                final color = colorMap[label]!;

                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5 * scale),
                  child: Row(
                    children: [
                      Container(
                        width: 10 * scale,
                        height: 10 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                        ),
                      ),
                      SizedBox(width: 8 * scale),
                      Expanded(
                        child: KText(
                          text: label,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          //color: AppColors.titleColor,
                        ),
                      ),
                      KText(
                        text: value.toString(),
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        //color: AppColors.titleColor,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
//HRMS Task Chat

class KPieChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final Map<String, Color> colorMap;
  final bool showTotal;
  final String totalLabel;

  const KPieChart({
    super.key,
    required this.dataMap,
    required this.colorMap,
    this.showTotal = true,
    this.totalLabel = "Total Task",
  });

  @override
  Widget build(BuildContext context) {
    //App Theme Data
    final theme = Theme.of(context);
    //final isDark = theme.brightness == Brightness.dark;
    final total = dataMap.values.fold<double>(0, (a, b) => a + b);

    return Center(
      child: SizedBox(
        width: 140.w,
        height: 140.w,
        child: Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              dataMap: dataMap,
              colorList: colorMap.values.toList(),
              chartType: ChartType.ring,
              ringStrokeWidth: 18.w,
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: false,
              ),
              legendOptions: const LegendOptions(showLegends: false),
            ),
            if (showTotal)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KText(
                    text: totalLabel,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColors.secondaryColor,
                  ),
                  buildTotalRichText(
                    total: total,
                    numberColor:
                        AppColors.secondaryColor, //AppColors.secondaryColor
                    labelColor:
                        AppColors.inReviewedColor, //AppColors.greyColor,
                    icon: Icons.arrow_upward_rounded,
                    gap: 8,
                    iconColor: AppColors.inReviewedColor,
                  ),

                  // KText(
                  //   text: total.toInt().toString(),
                  //   fontWeight: FontWeight.w700,
                  //   fontSize: 16.sp,
                  //   color: AppColors.secondaryColor,
                  // ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildTotalRichText({
    required num total,
    Color? numberColor,
    Color? labelColor,
    double? numberSize,
    double? labelSize,
    IconData icon = Icons.arrow_right_alt,
    Color? iconColor,
    double iconSize = 20,
    double gap = 3,
  }) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: total.toInt().toString(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: numberSize ?? 14.sp,
              color: numberColor ?? AppColors.secondaryColor,
            ),
          ),
          WidgetSpan(child: SizedBox(width: gap)),
          TextSpan(
            text: "8%",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: labelSize ?? 14.sp,
              color: labelColor ?? AppColors.greyColor,
            ),
          ),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Icon(
              icon,
              size: 16,
              color: iconColor ?? AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class KPieChartLegend extends StatelessWidget {
  final Map<String, Color> colorMap;

  const KPieChartLegend({super.key, required this.colorMap});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 40.w,
      runSpacing: 16.h,
      children: colorMap.entries.map((entry) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10.w,
              height: 10.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: entry.value, // ← same as pie chart
              ),
            ),
            SizedBox(width: 10.w),
            KText(
              text: entry.key,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              color: AppColors.secondaryColor,
            ),
          ],
        );
      }).toList(),
    );
  }
}
