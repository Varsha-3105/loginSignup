import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'widgets/custom_app_bar.dart';
import '../constants/app_colors.dart'; 

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double spacing = 8;
    final double cardWidth = (screenWidth - 32 - spacing) / 2;

    return Scaffold(
      appBar: const CustomAppBar(title: "Reports"),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: [
                _infoCard(
                  width: cardWidth,
                  title: "Total Working Days\n(This Month)",
                  value: "22 days",
                  icon: Icons.calendar_today,
                ),
                _infoCard(
                  width: cardWidth,
                  title: "Total Hours Worked",
                  value: "145 hrs",
                  icon: Icons.hourglass_bottom,
                ),
                _infoCard(
                  width: cardWidth,
                  title: "Tasks Completed",
                  value: "35",
                  icon: Icons.check_circle_outline,
                  subtext: "this month",
                ),
                _infoCard(
                  width: cardWidth,
                  title: "Average Daily Hours",
                  value: "6.6",
                  icon: Icons.alarm,
                  subtext: "hrs/day",
                ),
              ],
            ),
            const SizedBox(height: 25),

            const Text(
              "Daily Clock-In/Out Log",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _buildClockLogTable(),
            ),
            const SizedBox(height: 29),

            const Text(
              "Attendance",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                _statusIndicator(color: AppColors.success, label: "Present"),
                const SizedBox(width: 16),
                _statusIndicator(color: AppColors.error, label: "Absence"),
                const SizedBox(width: 16),
                _statusIndicator(color: AppColors.primary, label: "Avg hrs"),
              ],
            ),
            const SizedBox(height: 26),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                height: 160,
                child: _buildAttendanceChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required double width,
    required String title,
    required String value,
    required IconData icon,
    String? subtext,
  }) {
    return Container(
      width: width,
      height: 165,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textLight,
                  ),
                ),
              ),
              Icon(icon, size: 18, color: AppColors.primary),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.text,
                  ),
                ),
                if (subtext != null)
                  Text(
                    subtext,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textLight,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClockLogTable() {
    final List<Map<String, String>> logData = [
      {
        "date": "June 21",
        "checkIn": "09:15 AM",
        "checkOut": "05:45 PM",
        "total": "8.5 hrs",
        "status": "Present",
      },
      {
        "date": "June 22",
        "checkIn": "--",
        "checkOut": "--",
        "total": "0 hrs",
        "status": "Absent",
      },
      {
        "date": "June 23",
        "checkIn": "09:30 AM",
        "checkOut": "04:00 PM",
        "total": "6.5 hrs",
        "status": "Half Day",
      },
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey300, width: 2.0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DataTable(
        columnSpacing: 16,
        headingRowColor: MaterialStateProperty.all(AppColors.grey200),
        dividerThickness: 0,
        dataRowColor: MaterialStateProperty.all(Colors.transparent),
        columns: const [
          DataColumn(label: Text("Date")),
          DataColumn(label: Text("Check-in")),
          DataColumn(label: Text("Check-out")),
          DataColumn(label: Text("Total Hrs")),
          DataColumn(label: Text("Status")),
        ],
        rows: logData.map((entry) {
          Color statusColor;
          switch (entry['status']) {
            case 'Present':
              statusColor = AppColors.success;
              break;
            case 'Absent':
              statusColor = AppColors.error;
              break;
            case 'Half Day':
              statusColor = AppColors.orange;
              break;
            default:
              statusColor = AppColors.textLight;
          }

          return DataRow(cells: [
            DataCell(Text(entry['date']!)),
            DataCell(Text(entry['checkIn']!)),
            DataCell(Text(entry['checkOut']!)),
            DataCell(Text(entry['total']!)),
            DataCell(Text(
              entry['status']!,
              style: TextStyle(color: statusColor),
            )),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _statusIndicator({required Color color, required String label}) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.rectangle),
        ),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(fontSize: 14)),
      ],
    );
  }

  Widget _buildAttendanceChart() {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 12,
        borderData: FlBorderData(show: false),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.grey200,
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final months = [
                  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: AppColors.success,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(0, 8), FlSpot(1, 9), FlSpot(2, 7), FlSpot(3, 10),
              FlSpot(4, 9), FlSpot(5, 8), FlSpot(6, 11), FlSpot(7, 10),
              FlSpot(8, 10), FlSpot(9, 11), FlSpot(10, 11), FlSpot(11, 12),
            ],
          ),
          LineChartBarData(
            isCurved: true,
            color: AppColors.error,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(0, 2), FlSpot(1, 1), FlSpot(2, 3), FlSpot(3, 1),
              FlSpot(4, 2), FlSpot(5, 2), FlSpot(6, 1), FlSpot(7, 2),
              FlSpot(8, 2), FlSpot(9, 2), FlSpot(10, 1), FlSpot(11, 0),
            ],
          ),
          LineChartBarData(
            isCurved: true,
            color: AppColors.primary,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(show: false),
            spots: const [
              FlSpot(0, 5), FlSpot(1, 6), FlSpot(2, 5.5), FlSpot(3, 6),
              FlSpot(4, 6.5), FlSpot(5, 7), FlSpot(6, 6.5), FlSpot(7, 7),
              FlSpot(8, 6.8), FlSpot(9, 7), FlSpot(10, 7.2), FlSpot(11, 7.5),
            ],
          ),
        ],
      ),
    );
  }
}