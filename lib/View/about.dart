import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  // Launch URL
  void openLink(String link) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication);
    } else {
      throw 'Can not launch $link';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Me
            Container(
              height: 150.0,
              width: 150.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5.0,
                  color: Colors.blue,
                ),
                shape: BoxShape.circle,
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'images/Razzy.jpg',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'រិទ្ធ ធារ៉ា',
              style: GoogleFonts.kantumruyPro(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'នមស្សការ​និងចម្រើនពរ!',
              style: GoogleFonts.kantumruyPro(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                margin: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(
                    (Random().nextDouble() * 0xFFFFFF).toInt(),
                  ).withOpacity(.3),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        '   ព្រះសង្ឃគ្រប់ព្រះអង្គ និងគ្រប់គ្នា! នេះជា Note App សម្រាប់បញ្ចប់វគ្គ Basic Dart & Flutter | នៅសាលា ETEC Center(Online Class) របស់លោកគ្រូអាយធីចិត្តល្អ។',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 18.0,
                        ),
                      ),
                      Text(
                        '   សូមជួយផ្ដល់មតិដើម្បីកែលម្អ App នេះ ដល់ខ្ញុំកូណា អាត្មាភាព តាមរយ: Feedback ផង។',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Shimmer.fromColors(
              baseColor: Colors.deepPurple,
              highlightColor: Colors.cyan,
              child: Text(
                'ព័ត៌មានបន្ថែមសូមទំនាក់ទំនងតាមរយ:',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 18.0,
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    openLink('https://facebook.com/iammrazzy');
                  },
                  child: Shimmer.fromColors(
                    baseColor: Colors.deepPurple,
                    highlightColor: Colors.cyan,
                    child: const Icon(
                      Icons.facebook,
                      size: 35.0,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    openLink('https://t.me/iammrazzy');
                  },
                  child: Shimmer.fromColors(
                    baseColor: Colors.deepPurple,
                    highlightColor: Colors.cyan,
                    child: const Icon(
                      Icons.telegram,
                      size: 35.0,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () async {
                    openLink(
                      'mailto:riththeara103@gmail.com?subject=Your title&body=Your descriptions',
                    );
                  },
                  child: Shimmer.fromColors(
                    baseColor: Colors.deepPurple,
                    highlightColor: Colors.cyan,
                    child: const Icon(
                      Icons.email,
                      size: 35.0,
                    ),
                  ),
                ),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () async {
                    openLink(
                        'https://www.google.com/maps/place/Wat+Takhenvorn+(Trapeang+Orb)/@11.3898981,104.4350004,17z/data=!3m1!4b1!4m6!3m5!1s0x3109230ea266d2c3:0xdb5300d1babeeff!8m2!3d11.3898981!4d104.4375753!16s%2Fg%2F11rd85wd3f?entry=ttu');
                  },
                  child: Shimmer.fromColors(
                    baseColor: Colors.deepPurple,
                    highlightColor: Colors.cyan,
                    child: const Icon(
                      Icons.location_on,
                      size: 35.0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              'សូមអរព្រះគុណ និងអរគុណ!',
              style: GoogleFonts.kantumruyPro(
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 15.0),
            Image.asset(
              'images/newLogo.png',
              height: 50.0,
              width: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
