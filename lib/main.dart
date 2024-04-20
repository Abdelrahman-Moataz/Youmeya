import 'dart:io';
import 'package:youmeya/consent/consent.dart';
import 'package:youmeya/view/nav_bar/nav_bar.dart';
import 'package:youmeya/view/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  if (Platform.isAndroid) {
    print("done");
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDd47DBU0-yZmDQCeVi8bVPEhS2gfd8l1Y",
        appId: "1:158409675408:android:e3f5aa689da01188f67e15",
        messagingSenderId: "158409675408",
        projectId: "youmeya-478a9",
        storageBucket: "youmeya-478a9.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        // Check the authentication state
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If authentication state is still loading, show splash screen
            return const SplashScreen();
          } else {
            // If user is logged in, navigate to home screen
            if (snapshot.hasData && snapshot.data != null) {
              return const NavBar();
            } else {
              // If user is not logged in, navigate to splash screen
              return const SplashScreen();
            }
          }
        },
      ),
    );
  }
}
