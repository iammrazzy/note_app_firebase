import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_project/Model/note_model.dart';
import 'package:note_project/View/note_detail.dart';

class SearchNote extends StatefulWidget {
  const SearchNote({super.key});

  @override
  State<SearchNote> createState() => _SearchNoteState();
}

class _SearchNoteState extends State<SearchNote> {
  // Controller
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // Search controller
  final _searchController = TextEditingController();
  // Search query
  String? query;

  // Create a variable to store the selected category
  String? selectedCategory = '';

  // Create a list of categories to choose from
  List<String> categories = ['Personal', 'Work', 'School', 'Others'];

  @override
  Widget build(BuildContext context) {
    // Current user
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? uid = auth.currentUser?.uid;
    //
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Search field
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  // back button
                  Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  // Search field
                  Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search notes',
                        hintStyle: GoogleFonts.kantumruyPro(
                          fontSize: 16.0,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          onPressed: () {
                            _searchController.clear();
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                      onChanged: (value) {
                        query = value;
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (query != '' && query != null)
                    ? users
                        .doc(uid)
                        .collection('notes')
                        .where(
                          'note_title',
                          isGreaterThanOrEqualTo: query,
                        )
                        .snapshots()
                    : users.doc(uid).collection('notes').snapshots(),
                builder: (context, snapshot) {
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          padding: const EdgeInsets.all(5.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            NoteModel note = NoteModel.fromDucumentSnapShot(
                              snapshot.data!.docs[index],
                            );
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NoteDetail(note: note),
                                  ),
                                );
                              },
                              child: Card(
                                child: Container(
                                  margin: const EdgeInsets.all(3.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Color(
                                      (Random().nextDouble() * 0xFFFFFF)
                                          .toInt(),
                                    ).withOpacity(.3),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              note.noteTitle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                height: 40.0,
                                                width: 40.0,
                                                decoration: BoxDecoration(
                                                  color: Color(
                                                    (Random().nextDouble() *
                                                            0xFFFFFF)
                                                        .toInt(),
                                                  ).withOpacity(.5),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Center(
                                                  child: PopupMenuButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    itemBuilder: (context) => [
                                                      PopupMenuItem(
                                                        child: ListTile(
                                                          onTap: () async {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return SizedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      horizontal:
                                                                          15.0,
                                                                      vertical:
                                                                          18.0,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        TextField(
                                                                          controller:
                                                                              titleController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                note.noteTitle,
                                                                            hintStyle:
                                                                                GoogleFonts.kantumruyPro(
                                                                              fontSize: 17.0,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(12.0),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Colors.grey.withOpacity(.3),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                8.0),

                                                                        // Input description
                                                                        TextField(
                                                                          controller:
                                                                              descriptionController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                note.noteDescription,
                                                                            hintStyle:
                                                                                GoogleFonts.kantumruyPro(
                                                                              fontSize: 17.0,
                                                                            ),
                                                                            border:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12.0,
                                                                              ),
                                                                              borderSide: BorderSide.none,
                                                                            ),
                                                                            filled:
                                                                                true,
                                                                            fillColor:
                                                                                Colors.grey.withOpacity(.3),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                10.0),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
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
                                                                                  value: note.noteCategory,
                                                                                  items: categories.map((category) {
                                                                                    return DropdownMenuItem<String>(
                                                                                      value: category,
                                                                                      child: Text(category),
                                                                                    );
                                                                                  }).toList(),
                                                                                  onChanged: (newCategory) => setState(
                                                                                    () {
                                                                                      selectedCategory = newCategory.toString();
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        //Creat note button
                                                                        const SizedBox(
                                                                            height:
                                                                                10.0),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (titleController.text.isEmpty &&
                                                                                descriptionController.text.isEmpty) {
                                                                              print('Please enter title or description...!');
                                                                              Fluttertoast.showToast(
                                                                                msg: "Please enter title or description...!",
                                                                                toastLength: Toast.LENGTH_SHORT,
                                                                                gravity: ToastGravity.BOTTOM,
                                                                                timeInSecForIosWeb: 1,
                                                                                backgroundColor: Colors.red,
                                                                                textColor: Colors.white,
                                                                                fontSize: 16.0,
                                                                              );
                                                                            } else {
                                                                              CollectionReference users = FirebaseFirestore.instance.collection('users');
                                                                              FirebaseAuth auth = FirebaseAuth.instance;
                                                                              String uid = auth.currentUser!.uid.toString();
                                                                              users.doc(uid).collection('notes').doc(snapshot.data!.docs[index].id).update(
                                                                                {
                                                                                  'note_id': Timestamp.now(),
                                                                                  'note_title': titleController.text,
                                                                                  'note_description': descriptionController.text,
                                                                                  'note_category': selectedCategory,
                                                                                },
                                                                              ).whenComplete(() => Navigator.pop(context));
                                                                              print('Note updated in Firestore.');
                                                                            }
                                                                            //clear Text
                                                                            clearText();
                                                                          },
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            fixedSize:
                                                                                const Size(500, 50.0),
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(
                                                                                12.0,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Text(
                                                                            'Update',
                                                                            style:
                                                                                GoogleFonts.kantumruyPro(
                                                                              fontSize: 22.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          leading:
                                                              const CircleAvatar(
                                                            child: Icon(
                                                                Icons.edit),
                                                          ),
                                                          title: Text(
                                                            'Update',
                                                            style: GoogleFonts
                                                                .kantumruyPro(
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      PopupMenuItem(
                                                        child: ListTile(
                                                          onTap: () async {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                    "Confirm",
                                                                    style: GoogleFonts
                                                                        .kantumruyPro(
                                                                      fontSize:
                                                                          20.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  content: Text(
                                                                    "Are you sure you want to delete this item?",
                                                                    style: GoogleFonts
                                                                        .kantumruyPro(
                                                                      fontSize:
                                                                          18.0,
                                                                    ),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        "No",
                                                                        style: GoogleFonts
                                                                            .kantumruyPro(
                                                                          fontSize:
                                                                              18.0,
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () =>
                                                                              Navigator.of(context).pop(),
                                                                    ),
                                                                    TextButton(
                                                                      child:
                                                                          Text(
                                                                        "Yes",
                                                                        style: GoogleFonts
                                                                            .kantumruyPro(
                                                                          fontSize:
                                                                              18.0,
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        CollectionReference
                                                                            users =
                                                                            FirebaseFirestore.instance.collection('users');
                                                                        FirebaseAuth
                                                                            auth =
                                                                            FirebaseAuth.instance;
                                                                        String uid = auth
                                                                            .currentUser!
                                                                            .uid
                                                                            .toString();
                                                                        users
                                                                            .doc(uid)
                                                                            .collection('notes')
                                                                            .doc(snapshot.data!.docs[index].id)
                                                                            .delete();
                                                                        // ignore: use_build_context_synchronously
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          leading:
                                                              const CircleAvatar(
                                                            child: Icon(
                                                                Icons.delete),
                                                          ),
                                                          title: Text(
                                                            'Delete',
                                                            style: GoogleFonts
                                                                .kantumruyPro(
                                                              fontSize: 15.0,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          note.noteDescription,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: GoogleFonts.kantumruyPro(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        const SizedBox(height: 5.0),
                                        Text(
                                          '[ ${note.noteCategory} ]',
                                          style: GoogleFonts.kantumruyPro(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Clear text
  clearText() {
    titleController.clear();
    descriptionController.clear();
  }
}
