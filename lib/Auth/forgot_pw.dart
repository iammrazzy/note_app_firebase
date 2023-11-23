import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ForgotPw extends StatefulWidget {
  const ForgotPw({super.key});

  @override
  State<ForgotPw> createState() => _ForgotPwState();
}

class _ForgotPwState extends State<ForgotPw> {
  // text controller
  final emailAdressController = TextEditingController();

  @override
  void dispose() {
    emailAdressController.dispose();
    super.dispose();
  }

  // Loading
  bool _isReset = false;

  // Reset password
  Future<void> resetPassowrd() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAdressController.text.trim());
      Fluttertoast.showToast(
        msg: "Password Reset link was sent! Check your email.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.teal,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      // Show message when invalid email
      Fluttertoast.showToast(
        msg: 'Please enter E-mail you want to reset...!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      debugPrint(e.toString());
    }

    // clear E-mail when clicked
    emailAdressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'images/newLogo.png',
                      height: 150,
                    ),
                  ),

                  //Text
                  const SizedBox(height: 20),
                  Text(
                    'Enter your E-mail',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'to Reset Password',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text field
                  const SizedBox(height: 15),

                  TextFormField(
                    controller: emailAdressController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      hintText: 'E-mail',
                      hintStyle: GoogleFonts.kantumruyPro(fontSize: 17.0),
                      prefixIcon: const Icon(
                        Icons.email,
                      ),
                    ),
                  ),

                  // Reset button
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () async {
                      // Loading
                      setState(() => _isReset = true);
                      await resetPassowrd().whenComplete(
                        () => setState(() => _isReset = false),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: _isReset
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.fourRotatingDots(
                                color: Colors.deepPurple,
                                size: 40.0,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                'Loading',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Reset',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
