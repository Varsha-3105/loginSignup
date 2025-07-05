import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfController {
  static Future<void> generatePayslipPDF(BuildContext context, {String monthLabel = 'June 2025', required String dateOfJoining, required String payPeriod, required String payDate}) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Company Header
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: 50,
                    height: 50,
                    decoration: pw.BoxDecoration(
                      color: PdfColor.fromHex('#4CAF50'),
                      borderRadius: pw.BorderRadius.circular(25),
                    ),
                    child: pw.Center(
                      child: pw.Text('Z', style: pw.TextStyle(color: PdfColor.fromHex('#FFFFFF'), fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    ),
                  ),
                  pw.SizedBox(width: 12),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('ZiyaAcademy', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#2196F3'))),
                      pw.Text('KEY TO SUCCESS', style: pw.TextStyle(fontSize: 12, color: PdfColor.fromHex('#90EE90'), letterSpacing: 1.2)),
                    ],
                  ),
                  pw.Spacer(),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Text('Payslip for the Month', style: pw.TextStyle(fontSize: 10, color: PdfColor.fromHex('#888888'))),
                        pw.Text(monthLabel, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              // Employee Summary
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#FFFFFF'),
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(color: PdfColor.fromHex('#E0E0E0')),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('EMPLOYEE SUMMARY', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#888888'))),
                    pw.SizedBox(height: 12),
                    _pdfInfoRow('Employee Name', 'Hemant Rangarajan'),
                    _pdfInfoRow('Designation', 'Full-stack Developer'),
                    _pdfInfoRow('Employee ID', 'Employee ID'),
                    _pdfInfoRow('Date of Joining', dateOfJoining),
                    _pdfInfoRow('Pay Period', payPeriod),
                    _pdfInfoRow('Pay Date', payDate),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              // PF/UAN Section
              pw.Container(
                padding: const pw.EdgeInsets.all(16),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromHex('#F0F8FF'),
                  borderRadius: pw.BorderRadius.circular(12),
                  border: pw.Border.all(color: PdfColor.fromInt(0x4D2196F3)),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('PF A/C Number', style: pw.TextStyle(fontSize: 12, color: PdfColor.fromHex('#888888'))),
                    pw.SizedBox(width: 12),
                    pw.Text('AA/AAA/999999/990/9899', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(width: 24),
                    pw.Text('UAN', style: pw.TextStyle(fontSize: 12, color: PdfColor.fromHex('#888888'))),
                    pw.SizedBox(width: 12),
                    pw.Text('111111111111', style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              // Earnings/Deductions Table
              _pdfEarningsDeductionsTable(),
              pw.SizedBox(height: 20),
              // Net Pay Card
              _pdfNetPayCard(),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  static pw.Widget _pdfInfoRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 8),
      child: pw.Row(
        children: [
          pw.Container(
            width: 120,
            child: pw.Text(label, style: pw.TextStyle(fontSize: 12, color: PdfColor.fromHex('#888888'))),
          ),
          pw.Text(' : ', style: pw.TextStyle(color: PdfColor.fromHex('#888888'))),
          pw.Expanded(
            child: pw.Text(value, style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.normal)),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfEarningsDeductionsTable() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: pw.BorderRadius.circular(12),
        border: pw.Border.all(color: PdfColor.fromHex('#E0E0E0')),
      ),
      child: pw.Column(
        children: [
          // Header
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.only(
                topLeft: pw.Radius.circular(12),
                topRight: pw.Radius.circular(12),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(flex: 2, child: pw.Text('EARNINGS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12))),
                pw.Expanded(child: pw.Text('AMOUNT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12), textAlign: pw.TextAlign.center)),
                pw.Expanded(child: pw.Text('YTD', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12), textAlign: pw.TextAlign.center)),
                pw.Expanded(flex: 2, child: pw.Text('DEDUCTIONS', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12), textAlign: pw.TextAlign.center)),
                pw.Expanded(child: pw.Text('AMOUNT', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12), textAlign: pw.TextAlign.center)),
                pw.Expanded(child: pw.Text('YTD', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12), textAlign: pw.TextAlign.center)),
              ],
            ),
          ),
          // Rows (example data)
          _pdfTableRow('Basic', '\u20b925,000', '\u20b93,00,00', 'PF Deduction', '\u20b92,500', '\u20b930,000'),
          _pdfTableRow('HRA', '\u20b910,000', '\u20b91,20,00', 'Tax Deduction', '\u20b97,500', '\u20b990,000'),
          _pdfTableRow('Travel Allowance', '\u20b93,000', '\u20b936,000', '', '', ''),
          _pdfTableRow('Meal / Other Allowance', '\u20b92,000', '\u20b924,000', '', '', ''),
          // Totals
          pw.Container(
            padding: const pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#E1F5FE'),
              borderRadius: pw.BorderRadius.only(
                bottomLeft: pw.Radius.circular(12),
                bottomRight: pw.Radius.circular(12),
              ),
            ),
            child: pw.Row(
              children: [
                pw.Expanded(flex: 3, child: pw.Text('Gross Earnings', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Expanded(child: pw.Text('\u20b955,000', style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                pw.Expanded(flex: 2, child: pw.Text('Total Deductions', style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
                pw.Expanded(child: pw.Text('\u20b910,000', style: pw.TextStyle(fontWeight: pw.FontWeight.bold), textAlign: pw.TextAlign.center)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _pdfTableRow(String earning, String earningAmount, String earningYTD, String deduction, String deductionAmount, String deductionYTD) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: pw.Row(
        children: [
          pw.Expanded(flex: 2, child: pw.Text(earning, style: pw.TextStyle(fontSize: 12))),
          pw.Expanded(child: pw.Text(earningAmount, style: pw.TextStyle(fontSize: 12), textAlign: pw.TextAlign.center)),
          pw.Expanded(child: pw.Text(earningYTD, style: pw.TextStyle(fontSize: 12), textAlign: pw.TextAlign.center)),
          pw.Expanded(flex: 2, child: pw.Text(deduction, style: pw.TextStyle(fontSize: 12), textAlign: pw.TextAlign.center)),
          pw.Expanded(child: pw.Text(deductionAmount, style: pw.TextStyle(fontSize: 12), textAlign: pw.TextAlign.center)),
          pw.Expanded(child: pw.Text(deductionYTD, style: pw.TextStyle(fontSize: 12), textAlign: pw.TextAlign.center)),
        ],
      ),
    );
  }

  static pw.Widget _pdfNetPayCard() {
    return pw.Container(
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('#FFFFFF'),
        borderRadius: pw.BorderRadius.circular(14),
        border: pw.Border.all(color: PdfColor.fromHex('#E0E0E0')),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          // Top green section
          pw.Container(
            decoration: pw.BoxDecoration(
              color: PdfColor.fromHex('#EFFFE9'),
              borderRadius: pw.BorderRadius.only(
                topLeft: pw.Radius.circular(14),
                topRight: pw.Radius.circular(14),
              ),
            ),
            padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: pw.Row(
              children: [
                pw.Container(
                  width: 4,
                  height: 40,
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromHex('#4CAF50'),
                    borderRadius: pw.BorderRadius.circular(4),
                  ),
                ),
                pw.SizedBox(width: 12),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('₹45,000', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#000000'))),
                    pw.SizedBox(height: 2),
                    pw.Text('Employee Net Pay', style: pw.TextStyle(fontSize: 12, color: PdfColor.fromHex('#888888'))),
                  ],
                ),
              ],
            ),
          ),
          // Dotted divider
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: pw.Divider(color: PdfColor.fromHex('#E0E0E0'), thickness: 1),
          ),
          // Paid Days and LOP Days
          pw.Padding(
            padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: pw.Column(
              children: [
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text('Paid Days', style: pw.TextStyle(fontSize: 13, color: PdfColor.fromHex('#888888'))),
                    ),
                    pw.Text(':', style: pw.TextStyle(fontSize: 13, color: PdfColor.fromHex('#888888'))),
                    pw.SizedBox(width: 8),
                    pw.Text('31', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#000000'))),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text('LOP Days', style: pw.TextStyle(fontSize: 13, color: PdfColor.fromHex('#888888'))),
                    ),
                    pw.Text(':', style: pw.TextStyle(fontSize: 13, color: PdfColor.fromHex('#888888'))),
                    pw.SizedBox(width: 8),
                    pw.Text('0', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#000000'))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 