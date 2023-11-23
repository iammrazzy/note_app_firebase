import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  // Controller
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // Create a variable to store the selected category
  String? selectedCategory;

  // Create a list of categories to choose from
  List<String> categories = ['Personal', 'Work', 'School', 'Others'];

  // Bool
  bool isLoved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create note',
          style: GoogleFonts.kantumruyPro(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Input title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(.1),
              ),
            ),
            const SizedBox(height: 8.0),
            // Input description

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withOpacity(.1),
              ),
            ),

            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 45,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: const Icon(
                          Icons.bolt,
                          color: Colors.grey,
                        ),
                        hintText: 'Choose Item',
                        hintStyle: GoogleFonts.kantumruyPro(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      value: selectedCategory,
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (newCategory) => setState(
                        () {
                          selectedCategory = newCategory;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20.0),
            //Creat note button
            ElevatedButton(
              onPressed: () async {
                if (selectedCategory == null) {
                  print(
                      'Please enter title or description and select category...!');

                  Fluttertoast.showToast(
                    msg:
                        "Please enter title or description and select category...!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                } else {
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('users');
                  FirebaseAuth auth = FirebaseAuth.instance;
                  String uid = auth.currentUser!.uid.toString();
                  users.doc(uid).collection('notes').add(
                    {
                      'note_id': Timestamp.now(),
                      'note_title': titleController.text,
                      'note_description': descriptionController.text,
                      'note_category': selectedCategory,
                      'isLoved': isLoved,
                    },
                  ).whenComplete(() => Navigator.pop(context));
                  print('Note added to Firestore.');
                }
                clearText();
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(500, 50.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                'Create',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void clearText() {
    titleController.clear();
    descriptionController.clear();
  }
}
