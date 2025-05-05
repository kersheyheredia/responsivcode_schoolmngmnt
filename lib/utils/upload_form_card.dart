import 'package:enrollment_system/pages/class/enrollment_provider.dart';
import 'package:enrollment_system/utils/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:provider/provider.dart';

class UploadFormCard extends StatefulWidget {
  final String description;
  final String note;
  final bool isForm138;
  final VoidCallback onPressed;

  const UploadFormCard({
    super.key,
    required this.description,
    required this.note,
    required this.isForm138,
    required this.onPressed
  });

  @override
  State<UploadFormCard> createState() => _UploadFormCardState();
}

class _UploadFormCardState extends State<UploadFormCard> {
  String? selectedFileName;
  PlatformFile? selectedFile;
  File? previewFile;


  Future<void>pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf'],
        withData: true
      );

      if (result != null) {
        PlatformFile file = result.files.first;

        if (file.size > 5 * 1024 * 1024) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("File size exceeds 5MB limit")),
          );
          return;
        }

        final directory = await getTemporaryDirectory();
        final filePath = '${directory.path}/${file.name}';
        final newFile = File(filePath);
        await newFile.writeAsBytes(file.bytes!);

        setState(() {
          selectedFileName = file.name;
          selectedFile = file;
          previewFile = newFile;
        });

        // Store the file in the provider
        if (widget.isForm138) {
          Provider.of<EnrollmentProvider>(context, listen: false)
              .setFormFile(newFile, file.name);
        } else {
          Provider.of<EnrollmentProvider>(context, listen: false)
              .setPicFile(newFile, file.name);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${widget.isForm138 ? "Form 138" : "2x2 Pic"} uploaded: ${file.name}")),
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
  //preview file
  void previewFileDialog(){
    if(previewFile == null) return;

    String extension = selectedFileName!.split('.').last.toLowerCase();

    showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.all(12),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: extension == 'pdf'
                ? PDFView(
              filePath: previewFile!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: true,
              pageFling: true,
            )
                : extension == 'jpg' || extension == 'png'
                ? Image.file(previewFile!)
                : Center(
              child: Text(
                "Cannot preview this file type",
                style: GoogleFonts.poppins(fontSize: 14),
              ),
            ),
          ),
        )
    );
  }

  void removeFile() {
    setState(() {
      selectedFileName = null;
      selectedFile = null;
      previewFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("File removed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    //fot file name trimming
    String trimmedFileName(String fileName, {int maxLength = 30}){
      if(fileName.length <= maxLength) return fileName;
      return '${fileName.substring(0, maxLength)}...';
    }
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
                Tooltip(
                  message: selectedFileName!,
                  child: GestureDetector(
                    onTap: previewFileDialog,
                    child: Text(
                      '👁️ ${trimmedFileName(selectedFileName!)}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.blue,
                      ),
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
