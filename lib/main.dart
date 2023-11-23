import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_project/Auth/login_page.dart';
import 'package:note_project/Controller/theme_controller.dart';
import 'package:note_project/View/home.dart';
import 'package:note_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // for Firebase backend
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // for change them mode
  await GetStorage.init();
  runApp(const MyApp());
}

// Theme controller with GetX
ThemeModeController themeModeController = Get.put(ThemeModeController());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Current user
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    debugPrint('User UID: [${user?.uid}]');
  }

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(
      builder: (_) {
        return GetMaterialApp(
          title: 'Flutter course\'project. ETEC Center(Online Class) ',
          debugShowCheckedModeBanner: false,
          theme: themeModeController.theme,
          home: user != null ? const Home() : const LoginPage(),
        );
      },
    );
  }
}
