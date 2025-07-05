import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class HolidaysListScreen extends StatelessWidget {
  const HolidaysListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> holidays = [
      {
        'date': '17 June',
        'day': 'Tuesday',
        'name': 'Bakrid',
        'type': 'Public Holiday',
        'note': 'Company-wide holiday',
      },
      {
        'date': '15 August',
        'day': 'Thursday',
        'name': 'Independence Day',
        'type': 'National Holiday',
        'note': 'Paid Leave',
      },
      {
        'date': '23 October',
        'day': 'Wednesday',
        'name': 'Diwali',
        'type': 'Optional',
        'note': 'Can be applied',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logoimages.png', height: 32),
            const SizedBox(width: 8),
            const Expanded(
              child: Text('Holidays', style: TextStyle(color: Colors.black)),
            ),
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/Screenshot 2025-03-01 094607.png'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Summary Cards
              Row(
                children: [
                  _summaryCard('Total Holidays', '18 days', Icons.calendar_today, Colors.blue),
                  const SizedBox(width: 12),
                  _summaryCard('Upcoming Holidays', '4', Icons.event, Colors.green, subtitle: 'Bakrid - 17 June'),
                ],
              ),
              const SizedBox(height: 10),
              // Legend
              Row(
                children: [
                  _legendDot(Colors.green),
                  const SizedBox(width: 4),
                  const Text('Public'),
                  const SizedBox(width: 12),
                  _legendDot(Colors.orange),
                  const SizedBox(width: 4),
                  const Text('Optional'),
                  const SizedBox(width: 12),
                  _legendDot(Colors.blue),
                  const SizedBox(width: 4),
                  const Text('Company'),
                ],
              ),
              const SizedBox(height: 10),
              // Calendar
              TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: DateTime.utc(2025, 6, 17),
                calendarFormat: CalendarFormat.month,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, focusedDay) {
                    Color? color;
                    if (day.day == 17 && day.month == 6) color = Colors.green;
                    if (day.day == 20 && day.month == 6) color = Colors.orange;
                    if (day.day == 15 && day.month == 6) color = Colors.blue;
                    if (day.day == 25 && day.month == 6) color = Colors.blue;
                    if (color != null) {
                      return Container(
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              // Holiday Table
              _holidayTable(holidays),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryCard(String title, String value, IconData icon, Color color, {String? subtitle}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(title, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _legendDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _holidayTable(List<Map<String, String>> holidays) {
    final columns = ['Date', 'Day', 'Holiday Name', 'Type', 'Note'];
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: columns.map((col) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(col, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              ),
            )).toList(),
          ),
          const Divider(height: 1),
          // Data rows
          ...holidays.map((holiday) => Row(
            children: [
              Expanded(child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0), child: Text(holiday['date'] ?? ''))),
              Expanded(child: Text(holiday['day'] ?? '')),
              Expanded(child: Text(holiday['name'] ?? '')),
              Expanded(child: Text(holiday['type'] ?? '')),
              Expanded(child: Text(holiday['note'] ?? '')),
            ],
          )).toList(),
        ],
      ),
    );
  }
} 