import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../controllers/pdf_controller.dart';
import '../views/widgets/custom_app_bar.dart';

class PayslipScreen extends StatefulWidget {
  const PayslipScreen({super.key});

  @override
  State<PayslipScreen> createState() => _PayslipScreenState();
}

class _PayslipScreenState extends State<PayslipScreen> {
  // Payslip data for each month
  final Map<String, Map<String, String>> payslipData = {
    'June 2025': {
      'payPeriod': 'June 2025',
      'payDate': '15/07/2025',
      'dateOfJoining': '30/05/2025',
      'netPay': '₹45,000',
    },
    'May 2025': {
      'payPeriod': 'May 2025',
      'payDate': '15/06/2025',
      'dateOfJoining': '30/05/2025',
      'netPay': '₹45,000',
    },
    'April 2025': {
      'payPeriod': 'April 2025',
      'payDate': '15/05/2025',
      'dateOfJoining': '15/04/2025',
      'netPay': '₹43,500',
    },
  };
  String selectedMonth = 'June 2025';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCompanyHeader(),
            const SizedBox(height: 20),
            _buildEmployeeSummary(),
            const SizedBox(height: 20),
            _buildPFUANSection(),
            const SizedBox(height: 20),
            _buildEarningsDeductionsTable(),
            const SizedBox(height: 20),
            _buildNetPayCard(),
            const SizedBox(height: 20),
            _buildDownloadButton(),
            const SizedBox(height: 30),
            _buildPayslipHistory(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildCompanyHeader() {
    return Row(
      children: [
        // Company Logo
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [AppColors.punchInGradient3, AppColors.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: CircleAvatar(
                radius: 22,
                backgroundImage: AssetImage('assets/logoimages.png'),
              ),
        ),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ZiyaAcademy',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.blue,
              ),
            ),
            Text(
              'KEY TO SUCCESS',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.lightGreen,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Payslip for the Month',
                style: TextStyle(fontSize: 10, color: AppColors.grey),
              ),
              Text(
                selectedMonth,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeSummary() {
    final data = payslipData[selectedMonth]!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity1,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'EMPLOYEE SUMMARY',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow('Employee Name', 'Hemant Rangarajan'),
                _buildInfoRow('Designation', 'Full-stack Developer'),
                _buildInfoRow('Employee ID', 'Employee ID'),
                _buildInfoRow('Date of Joining', data['dateOfJoining'] ?? ''),
                _buildInfoRow('Pay Period', data['payPeriod'] ?? ''),
                _buildInfoRow('Pay Date', data['payDate'] ?? ''),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Container(
              width: 160,
              child: Card(
                color: AppColors.background,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 164, 214, 185),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 5,
                            height: 42,
                            decoration: BoxDecoration(color: AppColors.primary),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['netPay'] ?? '',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                              Text(
                                "Employee net pay",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Paid Days",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.grey,
                                ),
                              ),
                              Text(":"),
                              Text(
                                "31",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "LOP Days",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.grey,
                                ),
                              ),
                              Text(":"),
                              Text(
                                "0",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: AppColors.grey),
            ),
          ),
          const Text(' : ', style: TextStyle(color: AppColors.grey)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPFUANSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyWithOpacity1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PF A/C Number', style: TextStyle(fontSize: 12, color: AppColors.grey)),
          SizedBox(width: 12),
          const Text('AA/AAA/999999/990/9899', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          SizedBox(width: 24),
          const Text('UAN', style: TextStyle(fontSize: 12, color: AppColors.grey)),
          SizedBox(width: 12),
          const Text('111111111111', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildEarningsDeductionsTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity1,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                Expanded(flex: 2, child: Text('EARNINGS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                Expanded(child: Text('AMOUNT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('DEDUCTIONS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('AMOUNT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                Expanded(child: Text('YTD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
              ],
            ),
          ),
          // Rows
          _buildTableRow('Basic', '₹25,000', '₹3,00,00', 'PF Deduction', '₹2,500', '₹30,000'),
          _buildTableRow('HRA', '₹10,000', '₹1,20,00', 'Tax Deduction', '₹7,500', '₹90,000'),
          _buildTableRow('Travel Allowance', '₹3,000', '₹36,000', '', '', ''),
          _buildTableRow('Meal / Other Allowance', '₹2,000', '₹24,000', '', '', ''),
          // Totals
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: const Row(
              children: [
                Expanded(flex: 3, child: Text('Gross Earnings', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text('₹55,000', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                Expanded(flex: 2, child: Text('Total Deductions', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
                Expanded(child: Text('₹10,000', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(String earning, String earningAmount, String earningYTD, 
                       String deduction, String deductionAmount, String deductionYTD) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(earning, style: const TextStyle(fontSize: 12))),
          Expanded(child: Text(earningAmount, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Expanded(child: Text(earningYTD, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(deduction, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Expanded(child: Text(deductionAmount, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
          Expanded(child: Text(deductionYTD, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildNetPayCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity15,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Total Net Payable',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Gross Earnings-Total Deductions',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          ),
          // Right: Amount in green box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.lightGreenBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '₹ 45,000',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadButton() {
    return Container(
      width: double.infinity,
      height: 50,
      child: Builder(
        builder: (context) => ElevatedButton(
          onPressed: () {
            final data = payslipData[selectedMonth]!;
            PdfController.generatePayslipPDF(
              context,
              monthLabel: selectedMonth,
              dateOfJoining: data['dateOfJoining']!,
              payPeriod: data['payPeriod']!,
              payDate: data['payDate']!,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Download the sample salary slip format for PDF',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPayslipHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Monthly Payslip History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyWithOpacity1,
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Builder(
            builder: (context) => Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Row(
                    children: [
                      Expanded(child: Text('Month', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Expanded(child: Text('Net Pay', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                      Expanded(child: Text('Action', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center)),
                    ],
                  ),
                ),
                _buildHistoryRow(context, 'June 2025', payslipData['June 2025']!['netPay'] ?? ''),
                _buildHistoryRow(context, 'May 2025', payslipData['May 2025']!['netPay'] ?? ''),
                _buildHistoryRow(context, 'April 2025', payslipData['April 2025']!['netPay'] ?? ''),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow(BuildContext context, String month, String amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMonth = month;
        });
        // Optionally, you can still call PdfController.generatePayslipPDF(context, monthLabel: month);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.grey200, width: 0.5)),
        ),
        child: Row(
          children: [
            Expanded(child: Text(month, style: const TextStyle(fontSize: 12))),
            Expanded(child: Text(amount, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text('Generated', style: TextStyle(fontSize: 10, color: Colors.black)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.download, size: 12, color: AppColors.primary),
                    SizedBox(width: 2),
                    Text('Download', style: TextStyle(fontSize: 10, color: AppColors.primary)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.greyWithOpacity2,
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Home', true),
          _buildNavItem(Icons.history, 'History', false),
          _buildNavItem(Icons.exit_to_app, 'Leave', false),
          _buildNavItem(Icons.person, 'Profile', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.primary : AppColors.grey,
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.grey,
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}