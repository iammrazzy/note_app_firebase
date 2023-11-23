import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_project/Auth/login_page.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Deletion!',
              style: GoogleFonts.kantumruyPro(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const Divider(thickness: 2, color: Colors.grey),
            Text(
              '1. Are you sure you want to delete your account?',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '2. This action cannot be undone.',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '3. All of your data will be permanently deleted.',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '4. if you have any questions, please contact me.',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '4.  To delete your account, click on \'delete\'',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
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
                        "Are you sure you want to Delete your account?",
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
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        TextButton(
                          child: Text(
                            "Yes",
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 18.0,
                              color: Colors.red,
                            ),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.currentUser!
                                .delete()
                                .whenComplete(() {
                              Fluttertoast.showToast(
                                msg: "Account deleted...!",
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
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false,
                              );
                              print('Deleted user!');
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Delete',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
