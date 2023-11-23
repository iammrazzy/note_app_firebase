import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:note_project/Auth/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // text controller
  final emailAdressController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();

  // Show & hide passsword
  bool obscureText = true;
  // Loading
  bool isSignup = false;

  // Confirm password
  bool passwordConfirmed() {
    if (passwordController.text == conPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  // Show message
  void showMSG(String msg, Color color) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // User sign up account
  Future<void> userSignup() async {
    try {
      if (emailAdressController.text.isEmpty &&
          passwordController.text.isEmpty) {
        showMSG('Please enter E-mail and password...!', Colors.red);
        print('Please enter E-mail and password...!');
      } else {
        if (passwordConfirmed()) {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailAdressController.text.trim(),
                password: passwordController.text.trim(),
              )
              .whenComplete(() => Navigator.pop(context));
          // After signed up successful show an message
          showMSG('Signed up...!', Colors.teal);
          print('Signed up...!');
                }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showMSG('Weak password...!', Colors.red);
      } else if (e.code == 'email-already-in-use') {
        // print('The account already exists for that email.');
        showMSG('Already exists for that email...!', Colors.red);
      }
    } catch (e) {
      print(e);
    }
    clearText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20.0),
                  Center(
                    child: Container(
                      height: 160.0,
                      width: 160.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'images/newLogo.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sign up',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    'your Account',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  // Email
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
                  const SizedBox(height: 10),
                  // Password
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.kantumruyPro(fontSize: 17.0),
                      prefixIcon: const Icon(Icons.password, size: 25),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Confirm Password
                  TextFormField(
                    controller: conPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(.1),
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.kantumruyPro(fontSize: 17.0),
                      prefixIcon: const Icon(Icons.password, size: 25),

                      // Toggle icon to show and hide password
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              obscureText = !obscureText;
                            },
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // Login Button
                  ElevatedButton(
                    onPressed: () async {
                      // loading
                      setState(() => isSignup = true);
                      await userSignup().whenComplete(
                        () => setState(() => isSignup = false),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isSignup
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
                            'Sign Up',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have account?',
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Clear text after Login clicked
  void clearText() {
    emailAdressController.clear();
    passwordController.clear();
    conPasswordController.clear();
  }
}
