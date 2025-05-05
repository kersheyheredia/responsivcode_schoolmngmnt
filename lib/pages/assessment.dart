import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/custom_button.dart';
import 'package:enrollment_system/utils/receipt_upload.dart';
import 'package:enrollment_system/utils/top_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssessmentScreen extends StatefulWidget {
  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(),
        body: Column(
          children: [
            TopHeader(title: 'ASSESSMENT'),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                            height: 870), // Adjust height to position the image
                        Image.asset('lib/assets/images/bottom_design2.png')
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoRow("Name:", "SALAMANCA, IKINAMADA C."),
                              _buildInfoRow("Status:", "Officially Enrolled",
                                  color: Colors.green),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildInfoRow("Grade Level:", "Grade 7"),
                              _buildInfoRow("S.Y:", "2025-2026"),
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Fees:",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor),
                          ),
                          SizedBox(height: 10),
                          _buildFeesTable(),
                          SizedBox(height: 20),
                          Text("Payment Channels",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor)),
                          SizedBox(height: 10),
                          _buildPaymentTable(),
                          SizedBox(height: 15),
                          Text("Proof of Payment",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor
                            ),
                          ),
                          SizedBox(height: 10),
                          Text("Upload you payment receipt for the P500 entrance fee",
                            style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.primaryColor
                            ),
                          ),
                          SizedBox(height: 5),
                          Text("Accepted format: JPG, PNG, or PDF (Max 5MB)",
                            style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey
                            ),
                          ),
                          SizedBox(height: 30),
                          UploadFileWidget(),
                          SizedBox(height: 20),
                          Center(
                            child: CustomButton(
                              text: "Submit for Approval",
                              onPressed: () {
                                print("Button Pressed!");
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          SizedBox(width: 5),
          Text(value,
              style: TextStyle(color: color ?? Colors.black, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFeesTable() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 130),
      child: Table(
        columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(0.5)},
        children: [
          _buildTableRow("Tuition", "0.00"),
          _buildTableRow("Laboratory", "0.00"),
          _buildTableRow("Registration", "0.00"),
          _buildTableRow("Miscellaneous", "0.00"),
          _buildTableRow("Total Fees", "0.00", isBold: true),
          _buildTableRow("TOTAL DUE", "0.00", isBold: true),
          _buildTableRow("LESS Discounts", "0.00"),
          _buildTableRow("ADD Adjustments", "0.00"),
          _buildTableRow("Required for First Quarter", "0.00"),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, {bool isBold = false}) {
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Text(label,
              style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                  color: AppColors.primaryColor)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
          child: Text(value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              )),
        ),
      ],
    );
  }

  Widget _buildPaymentTable() {
    return Table(
      border: TableBorder.all(color: AppColors.primaryColor),
      columnWidths: {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
      children: [
        _buildPaymentRow("ABC Bank", "123-4-56789-10"),
        _buildPaymentRow("ABC Bank 2", "123-4-56789-10"),
        _buildPaymentRow("G-Cash", "+63 912 345 6789 (ABC University)"),
        _buildPaymentRow(
            "Remittance Centers", "(Specify 'ABC University' as receiver)"),
      ],
    );
  }

  TableRow _buildPaymentRow(String name, String details) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(details),
        ),
      ],
    );
  }
}
