import 'package:enrollment_system/utils/colors.dart';
import 'package:flutter/material.dart';

class UploadFileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45,
        width: 250,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black), // Outline border
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: AppColors.primaryColor, // Dark blue color
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.cloud_upload, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Upload File",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()), // Fills remaining space
          ],
        ),
      ),
    );
  }
}