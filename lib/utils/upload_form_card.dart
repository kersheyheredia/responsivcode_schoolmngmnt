import 'package:enrollment_system/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:html' as html;

class UploadFormCard extends StatefulWidget {
  final String description;
  final String note;
  final VoidCallback onPressed;

  const UploadFormCard({
    super.key,
    required this.description,
    required this.note,
    required this.onPressed,
  });

  @override
  State<UploadFormCard> createState() => _UploadFormCardState();
}

class _UploadFormCardState extends State<UploadFormCard> {
  String? selectedFileName;
  PlatformFile? selectedFile;
  void pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("File size exceeds 5MB limit")),
          );
          return;
        }

        setState(() {
          selectedFileName = file.name;
          selectedFile = file;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Selected file: ${file.name}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No file selected.")),
        );
      }
    } catch (e) {
      print("Error picking file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error picking file: $e")),
      );
    }
  }

  void removeFile() {
    setState(() {
      selectedFileName = null;
      selectedFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("File removed")),
    );
  }

  void downloadFile() async {
    if (selectedFile == null) return;

    try {
      if (kIsWeb) {
        // Web download
        final blob = html.Blob([selectedFile!.bytes!]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'web-download'
          ..download = selectedFile!.name
          ..click();
        html.Url.revokeObjectUrl(url);
      } else {
        // Mobile download - save and open the file
        final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/${selectedFile!.name}';
        final file = File(filePath);

        await file.writeAsBytes(selectedFile!.bytes!);
        await OpenFile.open(filePath);
      }
    } catch (e) {
      print("Error downloading file: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading file: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8.0),
          Text(
            widget.description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            widget.note,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16.0),

          // Display uploaded file with remove and download options
          if (selectedFileName != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Clickable File Name for download
                GestureDetector(
                  onTap: downloadFile,
                  child: Text(
                    '📥 $selectedFileName',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: removeFile,
                ),
              ],
            ),

          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                pickFile();
              },
              icon: const Icon(
                  Icons.cloud_upload,
                  color: Colors.white),
              label: Text(
                'Upload File',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
