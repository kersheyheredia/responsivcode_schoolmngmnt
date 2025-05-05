import 'package:enrollment_system/pages/model/enrollment_step.dart';
import 'package:enrollment_system/pages/model/pending_parent.dart';
import 'package:flutter/material.dart';
import 'service/api_service.dart';
import 'dart:math';

class Dummy extends StatefulWidget {
  const Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  late Future<List<PreAdmissionParent>> _preAdmissions;
  final ApiService apiService = ApiService();
  late Future<List<EnrollmentStep>> _stepsFuture;

  @override
  void initState() {
    super.initState();
    _preAdmissions = apiService.fetchPreAdmissionParent();
  }


  String generateParentNumber() {
    final random = Random();
    int number = 10000000 + random.nextInt(90000000); // Ensures 8-digit
    return number.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<PreAdmissionParent>>(
        future: _preAdmissions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No pre-admissions found.'));
          }

          final admissions = snapshot.data!;
          return ListView.builder(
            itemCount: admissions.length,
            itemBuilder: (context, index) {
              final parent = admissions[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(parent.parent_name),
                  subtitle: Text(parent.email_add),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () async{
                          final parentNumber = generateParentNumber();
                          final parentId = parent.id;
                          final person_type_id = "3";
                          try{
                            //save to person
                            final personId = await apiService.createPerson(
                              person_type_id,
                              parent.firstname,
                              parent.lastname,
                              parent.parent_name
                            );
                            //print("Creating person with: ${parent.firstname}, ${parent.lastname}, ${parent.parent_name}");
                            await apiService.saveParent(
                                parentId,
                                personId!
                            );

                            //save initial enrollment state
                            //await apiService.initEnrollmentSteps();
                          }catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Failed to send email: $e')),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          // decline logic here
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
