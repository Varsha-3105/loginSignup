import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2/constants/app_colors.dart';
import 'package:task2/controllers/employee_dashboard_controller.dart';
import 'EmployeeDashboardScreen.dart';
import 'widgets/custom_calendar.dart';
import 'widgets/custom_app_bar.dart';

class HolidayListScreen extends StatefulWidget {
  const HolidayListScreen({Key? key}) : super(key: key);

  @override
  State<HolidayListScreen> createState() => _HolidayListScreenState();
}

class _HolidayListScreenState extends State<HolidayListScreen> {
  // // final DateTime _selectedDate = DateTime.now();
  // final int _selectedMonth = DateTime.now().month;
  // final int _selectedYear = DateTime.now().year;
  final EmployeeDashboardController _dashboardController = Get.find<EmployeeDashboardController>();
  DateTime _focusedDay = DateTime.now();

  final Map<int, Map<String, dynamic>> _holidays = {
    3: {'type': 'Public Holiday', 'color': AppColors.green},
    12: {'type': 'Public Holiday', 'color': AppColors.green},
    16: {'type': 'Company Holiday', 'color': AppColors.blue},
    17: {'type': 'Company Holiday', 'color': AppColors.blue},
    20: {'type': 'Optional Holiday', 'color': AppColors.orange},
    25: {'type': 'Company Holiday', 'color': AppColors.blue},
  };

  
  
  final List<Map<String, String>> _upcomingHolidays = [
    {'date': '17 June', 'day': 'Tuesday', 'name': 'Bakrid', 'type': 'Public Holiday', 'note': 'Company-wide holiday'},
    {'date': '15 August', 'day': 'Thursday', 'name': 'Independence Day', 'type': 'National Holiday', 'note': 'Paid Leave'},
    {'date': '23 October', 'day': 'Wednesday', 'name': 'Diwali', 'type': 'Optional', 'note': 'Can be applied'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHolidayStats(),
                    _buildLegend(),
                    _buildCalendar(),
                    _buildHolidayTable(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(Icons.home, 'Home', _dashboardController.selectedTabIndex.value == 0, () {
            _dashboardController.selectedTabIndex.value = 0;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmployeeDashboardScreen()));
          }),
          _buildBottomNavItem(Icons.history, 'History', _dashboardController.selectedTabIndex.value == 1, () {
            _dashboardController.selectedTabIndex.value = 1;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmployeeDashboardScreen()));
          }),
          _buildBottomNavItem(Icons.calendar_today, 'Leave', _dashboardController.selectedTabIndex.value == 2, () {
            _dashboardController.selectedTabIndex.value = 2;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmployeeDashboardScreen()));
          }),
          _buildBottomNavItem(Icons.person, 'Profile', _dashboardController.selectedTabIndex.value == 3, () {
            _dashboardController.selectedTabIndex.value = 3;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EmployeeDashboardScreen()));
          }),
        ],
      )),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? AppColors.lightBlueAccent : AppColors.grey,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? AppColors.blueAccent : AppColors.grey,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: _buildStatCard(
              'Total\nHolidays',
              '18 days',
              'in a year',
              Icons.calendar_today,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildStatCard(
              'Upcoming\nHolidays',
              '4',
              '(04/06 - 17 June)',
              Icons.upcoming,
              subtitle2: '21 days remaining this month',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, IconData icon, {String? subtitle2}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity1,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.grey600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.grey500,
                    fontSize: 12,
                  ),
                ),
                if (subtitle == 'in a year') ...[
                  const SizedBox(height: 8),
                  Container(
                    width: 90,
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blue400,
                          AppColors.blue200,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ],
                if (subtitle2 != null && subtitle2.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    subtitle2,
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Icon(icon, color: AppColors.blue600, size: 32),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildLegendItem('Public', AppColors.green),
          const SizedBox(width: 20),
          _buildLegendItem('Optional', AppColors.orange),
          const SizedBox(width: 20),
          _buildLegendItem('Company', AppColors.blue),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey600,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar() {
    return CustomCalendar(
      focusedDate: _focusedDay,
      events: _holidays,
      onDayTap: (day) {
        // Handle day tap if needed
        print('Tapped on holiday day: $day');
      },
      onMonthChanged: (newDate) {
        setState(() {
          _focusedDay = newDate;
        });
      },
      showNavigationArrows: true,
    );
  }

  Widget _buildHolidayTable() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      width: MediaQuery.of(context).size.width - 40,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200, width: 1),
      ),
      child: Table(
        border: TableBorder.all(color: AppColors.grey200, width: 1),
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(1.5),
        },
        children: [
          TableRow(
            children: [
              _tableCell('Date', isHeader: true),
              _tableCell('17 June'),
              _tableCell('15 August'),
              _tableCell('23 October'),
            ],
          ),
          TableRow(
            children: [
              _tableCell('Day', isHeader: true),
              _tableCell('Tuesday'),
              _tableCell('Thursday'),
              _tableCell('Wednesday'),
            ],
          ),
          TableRow(
            children: [
              _tableCell('Holiday Name', isHeader: true),
              _tableCell('Bakrid'),
              _tableCell('Independence Day'),
              _tableCell('Diwali'),
            ],
          ),
          TableRow(
            children: [
              _tableCell('Type', isHeader: true),
              _tableCell('Public Holiday'),
              _tableCell('National Holiday'),
              _tableCell('Optional'),
            ],
          ),
          TableRow(
            children: [
              _tableCell('Note', isHeader: true),
              _tableCell('Company-wide holiday'),
              _tableCell('Paid Leave'),
              _tableCell('Can be applied'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return SizedBox(
      height: 48,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(
            color: isHeader ? AppColors.blue : AppColors.grey800,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
} 