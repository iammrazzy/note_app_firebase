import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  // Controller
  final TextEditingController _feedbackController = TextEditingController();
  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Text(
              'Your feedback is important!',
              style: GoogleFonts.kantumruyPro(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Please give me below:',
              style: GoogleFonts.kantumruyPro(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15.0),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _feedbackController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Give feedback here...',
                  hintStyle: GoogleFonts.kantumruyPro(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                  filled: false,
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                maxLines: 10,
                maxLength: 5000,
                textInputAction: TextInputAction.done,
                validator: (String? text) {
                  if (text == null || text.isEmpty) {
                    return 'Please enter your feedback before submit!';
                  }
                  return null;
                },
              ),
            ),
            // Submit button
            const SizedBox(height: 15.0),
            ElevatedButton(
              onPressed: () async {
                // Only if the input form is valid (the user has entered text)
                if (_formKey.currentState!.validate()) {
                  try {
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('users');
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String uid = auth.currentUser!.uid.toString();
                    users.doc(uid).collection('feedback').add(
                      {
                        'feedback_id': Timestamp.now(),
                        'feedback_msg': _feedbackController.text.trim(),
                      },
                    ).whenComplete(() {
                      Fluttertoast.showToast(
                        msg: "Feedback sent successfullly...!",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.teal,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                      Navigator.pop(context);
                      print('Feedback sent successfullly...!');
                    });
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Error while sending feedback...!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                    print(e);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(MediaQuery.of(context).size.width, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text(
                'Submit',
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
