import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_project/View/note_home.dart';
import 'package:note_project/View/user_acc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List pages = [
    const NoteHome(),
    const UserAccount(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 25.0,
        selectedLabelStyle: GoogleFonts.kantumruyPro(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: GoogleFonts.kantumruyPro(
          fontSize: 15.0,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
