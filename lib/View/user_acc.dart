import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_project/Auth/delete_acc.dart';
import 'package:note_project/Auth/login_page.dart';
import 'package:note_project/View/about.dart';
import 'package:note_project/View/feed_back.dart';
import 'package:note_project/main.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({super.key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  // Current user
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Cover photo
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/Angkor.jpg'),
                    ),
                  ),
                ),

                // Profile photo
                Container(
                  margin: const EdgeInsets.only(top: 110),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: user!.photoURL == null
                        ? Image.asset(
                            'images/Profile.jpg',
                            fit: BoxFit.cover,
                            width: 130.0,
                            height: 130.0,
                          )
                        : Image.network(
                            user!.photoURL.toString(),
                            fit: BoxFit.cover,
                            width: 130.0,
                            height: 130.0,
                          ),
                  ),
                ),

                // Icon shield & camera
                Container(
                  margin: const EdgeInsets.only(top: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 95),
                      Container(
                        height: 35.0,
                        width: 35.0,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          color: Colors.blue,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // User name
            const SizedBox(height: 15.0),
            SizedBox(
              child: user?.displayName == null
                  ? Text(
                      'No username',
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.withOpacity(.5),
                      ),
                    )
                  : Text(
                      user!.displayName.toString(),
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            Text(
              user!.email.toString(),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: GoogleFonts.kantumruyPro(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            const Divider(thickness: 1),

            // Item scrollings
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.settings_applications_sharp,
                          ),
                          title: Text(
                            'Appearance',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 17.0,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 200.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 25.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Change theme mode',
                                          style: GoogleFonts.kantumruyPro(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 10.0),
                                        const Divider(thickness: 1),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Light mode',
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Switch(
                                              value: themeModeController.isDark,
                                              onChanged: themeModeController
                                                  .changeTheme,
                                            ),
                                            Text(
                                              'Dark mode',
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.info),
                          title: Text(
                            'About',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 17.0,
                            ),
                          ),
                          onTap: () => Get.to(() => const About()),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(Icons.feedback),
                          title: Text(
                            'Feedback',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 17.0,
                            ),
                          ),
                          onTap: () => Get.to(() => const FeedBack()),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text(
                            'Sign out',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 17.0,
                            ),
                          ),
                          leading: const Icon(Icons.logout),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    "Confirm",
                                    style: GoogleFonts.kantumruyPro(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    "Are you sure you want to Sign Out of your account?",
                                    style: GoogleFonts.kantumruyPro(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        "No",
                                        style: GoogleFonts.kantumruyPro(
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    TextButton(
                                      child: Text(
                                        "Yes",
                                        style: GoogleFonts.kantumruyPro(
                                          fontSize: 18.0,
                                          color: Colors.red,
                                        ),
                                      ),
                                      onPressed: () {
                                        FirebaseAuth.instance
                                            .signOut()
                                            .whenComplete(() {
                                          Fluttertoast.showToast(
                                            msg: "Signed out...!",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                          Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ),
                                            (route) => false,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          enabled: true,
                          leading: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                          title: Text(
                            'Delete account',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 17.0,
                              color: Colors.red,
                            ),
                          ),
                          onTap: () => Get.to(() => const DeleteAccount()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
