import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/top_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EGrades extends StatefulWidget {
  const EGrades({super.key});

  @override
  State<EGrades> createState() => _EGradesState();
}

class _EGradesState extends State<EGrades> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          TopHeader(title: 'GRADES',),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                          height: 500), // Adjust height to position the image
                      Image.asset('lib/assets/images/bottom_design2.png')
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoRow(
                                        "Name:", "SALAMANCA, IKINAMADA C."),
                                    _buildInfoRow(
                                        "Status:", "Officially Enrolled",
                                        color: Colors.green),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildInfoRow("Grade Level:", "Grade 7"),
                                    _buildInfoRow("S.Y:", "2025-2026"),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ])),
                      _buildTableGrade()
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
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

  Widget _buildTableGrade() {
    return Column(
      children: [
        // Header Row — Full width with light blue background

        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlue.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            children: const [
              Expanded(
                  flex: 2,
                  child: Text("Subjects",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 3,
                  child: Text("Description",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text("1st",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text("2nd",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text("3rd",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(
                  flex: 1,
                  child: Text("4th",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
        ),

        // Table rows with horizontal borders and internal padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
              5: FlexColumnWidth(1),
            },
            border: const TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey,
                width: 0.8,
              ),
            ),
            children: List.generate(5, (index) {
              return TableRow(
                children: [
                  _buildHeaderCell("Subject - ${index + 1}"),
                  _buildHeaderCell("Subject in ResponsivCode"),
                  _buildHeaderCell("75"),
                  _buildHeaderCell(""),
                  _buildHeaderCell(""),
                  _buildHeaderCell(""),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  //header
  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),
      ),
    );
  }
}
