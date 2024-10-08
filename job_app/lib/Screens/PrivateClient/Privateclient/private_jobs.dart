// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/PrivateClient/privateclient_controller.dart';

class PrivateJobs extends StatefulWidget {
  const PrivateJobs({super.key});

  @override
  State<PrivateJobs> createState() => _PrivateJobsState();
}

class _PrivateJobsState extends State<PrivateJobs> {
  @override
  void initState() {
    super.initState();
    _privateclientController.getPrivateJobs();
  }

  final PrivateclientController _privateclientController =
      Get.put(PrivateclientController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _privateclientController.getPrivateJobs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (_privateclientController.privatejobs.isEmpty) {
            return Center(
                child: Text("No jobs posted", style: GoogleFonts.poppins()));
          } else {
            return Obx(() {
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var jobs = _privateclientController.privatejobs[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(8.0),
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    jobs["title"] ?? "Not Provided",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.timer,color: Colors.red,size: 20),
                                  Text(
                                      "${jobs["deadline"] ?? "Not Provided"}",
                                      style: GoogleFonts.poppins()),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Type: ${jobs["type"] ?? "Not Provided"}",
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Sector: ${jobs["sector"] ?? "Not Provided"}",
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "City: ${jobs["city"] ?? "Not Provided"}",
                                style: GoogleFonts.poppins(),
                              ),
                              SizedBox(height: 4),
                              Text(
                                  "Gender: ${jobs["gender"] ?? "Not Provided"}",
                                  style: GoogleFonts.poppins()),
                              SizedBox(height: 4),
                              Text(
                                  "Salary: ${jobs["salary"] ?? "Not Provided"}",
                                  style: GoogleFonts.poppins()),
                              SizedBox(height: 4),
                              Text(
                                "Description: ${jobs["description"] ?? "Not Provided"}",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, index) {
                    return SizedBox(height: 3);
                  },
                  itemCount: _privateclientController.privatejobs.length);
            });
          }
        });
  }
}
