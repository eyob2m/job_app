// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_app/Controllers/JobSeeker/jobseeker_controller.dart';
import 'package:job_app/Controllers/Profile/ProfileController.dart';
import 'package:job_app/Controllers/User/UserController.dart';
import 'package:job_app/Screens/Company/company_homepage.dart';
import 'package:job_app/Screens/Job/add_job.dart';
import 'package:job_app/Screens/JobSeeker/job_seeker_homepage.dart';
import 'package:job_app/Screens/PrivateClient/Privateclient/private_applications.dart';
import 'package:job_app/Screens/PrivateClient/Privateclient/private_jobs.dart';
import 'package:job_app/Screens/PrivateClient/Privateclient/private_profile.dart';
import 'package:job_app/Screens/Profiles/profiles.dart';

class PrivateClientHomepage extends StatefulWidget {
  const PrivateClientHomepage({super.key});

  @override
  State<PrivateClientHomepage> createState() => _PrivateClientHomepageState();
}

class _PrivateClientHomepageState extends State<PrivateClientHomepage> {
  final JobSeekerController _jobSeekerController =
      Get.put(JobSeekerController());
  final ProfileController _profileController = Get.put(ProfileController());
  final UserAuthenticationController _userAuthenticationController =
      Get.put(UserAuthenticationController());
  String selectedProfile = 'privateclient';
  int currentindex = 0;
  final PageController _pageController = PageController();
  List<dynamic> jobs = <dynamic>[];
  @override
  void initState() {
    super.initState();
    _jobSeekerController.getJobSeeker();
    _jobSeekerController.fetchJobSeeker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("My Job Posts",
                    style: GoogleFonts.poppins(
                        fontSize: 24, color: Color(0xFFFF9228))),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder:
                                  (BuildContext context, StateSetter setState) {
                                return Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.45,
                                  child: Column(
                                    children: [
                                      if (_profileController.isloading.value)
                                        Center(
                                            child: CircularProgressIndicator())
                                      else ...[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8, left: 18, top: 18),
                                          child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text("My Accounts",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 22))),
                                        ),
                                        if (_profileController
                                                .profiles["jobseeker"] !=
                                            null)
                                          _profileContainer(
                                              ListTile(
                                                leading: Image.asset(
                                                  "assets/icons/job_seeker.png",
                                                  width: 28,
                                                  color: Color(0xFFFF9228)
                                                      .withOpacity(0.4),
                                                ),
                                                title: Text(
                                                  _profileController.profiles[
                                                                  'jobseeker']
                                                              ['user']
                                                          ['firstname'] +
                                                      " " +
                                                      _profileController
                                                                  .profiles[
                                                              'jobseeker']
                                                          ['user']['lastname'],
                                                ),
                                                subtitle: Text("Job Seeker"),
                                                trailing: Radio(
                                                  value: 'jobseeker',
                                                  groupValue: selectedProfile,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedProfile =
                                                          value.toString();
                                                      if (selectedProfile ==
                                                          "jobseeker") {
                                                        Get.offAll(
                                                            JobSeekerHomepage());
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              "jobseeker", () {
                                            Get.offAll(JobSeekerHomepage());
                                          }),
                                        if (_profileController
                                                .profiles["privateclient"] !=
                                            null)
                                          _profileContainer(
                                              ListTile(
                                                leading: Image.asset(
                                                  "assets/icons/private.png",
                                                  width: 28,
                                                  color: Color(0xFFFF9228)
                                                      .withOpacity(0.4),
                                                ),
                                                title: Text(
                                                  _profileController.profiles[
                                                                  'jobseeker']
                                                              ['user']
                                                          ['firstname'] +
                                                      " " +
                                                      _profileController
                                                                  .profiles[
                                                              'jobseeker']
                                                          ['user']['lastname'],
                                                ),
                                                subtitle:
                                                    Text("Private Client"),
                                                trailing: Radio(
                                                  value: 'privateclient',
                                                  groupValue: selectedProfile,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedProfile =
                                                          value.toString();
                                                    });
                                                  },
                                                ),
                                              ),
                                              "private",
                                              () {}),
                                        if (_profileController
                                                .profiles["company"] !=
                                            null)
                                          _profileContainer(
                                              ListTile(
                                                leading: Image.asset(
                                                  "assets/icons/company.png",
                                                  width: 28,
                                                  color: Color(0xFFFF9228)
                                                      .withOpacity(0.4),
                                                ),
                                                title: Text(_profileController
                                                        .profiles["company"]
                                                    ["company_name"]),
                                                subtitle: Text("Company"),
                                                trailing: Radio(
                                                  value: 'company',
                                                  groupValue: selectedProfile,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedProfile =
                                                          value.toString();
                                                      if (selectedProfile ==
                                                          "company") {
                                                        Get.offAll(
                                                            CompanyHomepage());
                                                      }
                                                    });
                                                  },
                                                ),
                                              ),
                                              "company", () {
                                            Get.offAll(CompanyHomepage());
                                          }),
                                      ],
                                      if (_profileController
                                                  .profiles["jobseeker"] ==
                                              null ||
                                          _profileController
                                                  .profiles["company"] ==
                                              null)
                                        Padding(
                                          padding: EdgeInsets.all(20),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Profiles()));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(20),
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 80,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey
                                                          .withOpacity(0.2)),
                                                  child: Text("Add Account",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Color(
                                                                  0xFF130160),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      GestureDetector(
                                        onTap: () {
                                          _userAuthenticationController
                                              .logout();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.logout_outlined,
                                              color: Color(0xFF130160),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text("LOG OUT",
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                          Color(0xFF130160))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Image.asset("assets/icons/switch.png")),
                )
              ],
            ),
            SizedBox(height: 15),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentindex = index;
                  });
                },
                children: [PrivateJobs(), PrivateApplications()],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  margin: EdgeInsets.only(bottom: 30, right: 10),
                  child: FloatingActionButton(
                      backgroundColor: Color(0xFFFF9228),
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AddJob()));
                      })),
            ),
            BottomNavigationBar(
              currentIndex: currentindex,
              onTap: (index) {
                if (index == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PrivateProfile()));
                } else {
                  setState(() {
                    currentindex = index;
                    _pageController.jumpToPage(index);
                  });
                }
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.work),
                  label: 'My Jobs',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.description),
                  label: 'My Applications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              elevation: 0,
              selectedLabelStyle:
                  GoogleFonts.poppins(fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    ));
  }

  Widget _profileContainer(
      Widget child, String value, VoidCallback onNavigator) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedProfile = value;
        });
        onNavigator();
      },
      child: Container(
        child: child,
      ),
    );
  }
}
