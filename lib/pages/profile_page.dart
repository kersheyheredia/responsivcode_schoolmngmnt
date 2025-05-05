import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // This makes sure the stack behaves as expected
            SizedBox(
              height: 200,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  // Background image
                  Image.asset(
                    'lib/assets/images/bg.png',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  // Profile avatar overlapping bottom of the background
                  Positioned(
                    bottom: -50, // pushes avatar slightly below the image
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 46,
                            backgroundImage: NetworkImage(
                                'https://example.com/user-profile.jpg'), // Replace with actual source
                          ),
                        ),

                        // Edit Icon
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Roger John Salamanca",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text("rjs@gmail.com | +63 912 345 6789"),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.edit_square, color: Colors.black),
                      title: Text("Edit profile information"),
                      onTap: () {
                        // Handle edit profile tap
                      },
                    ),
                   // Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.notifications_none, color: Colors.black),
                      title: Text("Notifications"),
                      trailing: Text(
                        "ON",
                        style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Toggle notifications
                      },
                    ),
                    //Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.language, color: Colors.black),
                      title: Text("Language"),
                      trailing: Text(
                        "English",
                        style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Change language
                      },
                    ),
                  ],
                ),
              ),
            ),

            //second card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.support, color: Colors.black),
                      title: Text("Help & Support"),
                      onTap: () {
                        // Handle edit profile tap
                      },
                    ),
                    // Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.notifications_none, color: Colors.black),
                      title: Text("Notifications"),
                      trailing: Text(
                        "ON",
                        style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Toggle notifications
                      },
                    ),
                    //Divider(height: 1),

                    ListTile(
                      leading: Icon(Icons.language, color: Colors.black),
                      title: Text("Language"),
                      trailing: Text(
                        "English",
                        style: TextStyle(color: Colors.indigo[900], fontWeight: FontWeight.w500),
                      ),
                      onTap: () {
                        // Change language
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
