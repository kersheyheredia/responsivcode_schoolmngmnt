import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadFormCard extends StatelessWidget {
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
            description,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            note,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {},
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
