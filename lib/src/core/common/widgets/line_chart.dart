// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task/src/features/home/view_models/invoice_view_model.dart';

// class Chart extends StatelessWidget {
//   const Chart({super.key});

//   final List<Color> gradientColors = const [
//     CupertinoColors.systemBlue,
//     CupertinoColors.systemPurple,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<FlSpot>>(
//         future: context.watch<InvoiceViewModel>().getWeeklySalesData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           List<FlSpot> spots = snapshot.data ?? [];

//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               width: double.infinity,
//               height: 300,
//               child: LineChart(
//                 LineChartData(
//                   borderData: FlBorderData(
//                       border: Border.all(color: Colors.black12, width: 1)),
//                   lineBarsData: [
//                     LineChartBarData(
//                       isCurved: true,
//                       barWidth: 3,
//                       isStrokeCapRound: true,
//                       dotData: const FlDotData(),
//                       belowBarData: BarAreaData(
//                         show: true,
//                         gradient: LinearGradient(
//                           colors: gradientColors
//                               .map((color) => color.withOpacity(0.3))
//                               .toList(),
//                         ),
//                       ),
//                       spots: spots,
//                     ),
//                   ],
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) {
//                           return SideTitleWidget(
//                             axisSide: meta.axisSide,
//                             child: Text(
//                               value.toString(),
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 40,
//                         getTitlesWidget: (value, meta) {
//                           final month = getMonthFromIndex(value.toInt());
//                           return SideTitleWidget(
//                             axisSide: meta.axisSide,
//                             child: Text(
//                               month,
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String getMonthFromIndex(int index) {
//     // Example:
//     const months = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     return months[index % 12];
//   }
// }
