import 'package:enrollment_system/pages/header_info.dart';
import 'package:enrollment_system/pages/model/section.dart';
import 'package:enrollment_system/pages/model/subject_select.dart';
import 'package:enrollment_system/pages/service/api_service.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:enrollment_system/utils/subject_selection_table.dart';
import 'package:enrollment_system/utils/top_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectSelection extends StatefulWidget {
  const SubjectSelection({super.key});

  @override
  State<SubjectSelection> createState() => _SubjectSelectionState();
}

class _SubjectSelectionState extends State<SubjectSelection> {
  Future<Map<String, List<SubjectSelect>>>? _futureData;
  final apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _futureData = apiService.fetchSections(); // or fetchSectionsFromFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          TopHeader(title: 'SUBJECT SELECTION'),
          SizedBox(height: 10),
          HeaderInfo(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text("Sort by: "),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                 //   decoration: const InputDecoration(labelText: "Sort by"),
                  //  value: "Default",
                    items: ["Default", "Subject Name", "Room"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e,
                      style: GoogleFonts.poppins(
                        color: AppColors.primaryColor,
                        fontSize: 12
                      ),)))
                        .toList(),
                    onChanged: (_) {},
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Search",
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 475), // Adjust height to position the image
                        Image.asset('lib/assets/images/bottom_design2.png')
                      ],
                    ),
                    FutureBuilder<Map<String, List<SubjectSelect>>>(
                      future: _futureData!,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(child: Text("Error: ${snapshot.error}"));
                        }
                        final allSections = snapshot.data!;
                        final filteredSections = allSections.entries
                            .where((entry) => entry.value.isNotEmpty)
                            .fold<Map<String, List<SubjectSelect>>>({}, (map, entry) {
                          map[entry.key] = entry.value;
                          return map;
                        });

                        if (filteredSections.isEmpty) {
                          return const Center(child: Text("No subjects available."));
                        }

                        return SubjectSelectionTable(sectionSubjects: filteredSections);
                      },
                    ),

                  ],

                ),

              ),

          ),

        ],
      ),
    );
  }
}
