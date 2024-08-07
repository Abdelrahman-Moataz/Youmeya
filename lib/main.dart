import 'dart:io';
import 'package:youmeya/consent/consent.dart'; // Ensure this is a valid import
import 'package:youmeya/view/nav_bar/nav_bar.dart';
import 'package:youmeya/view/splash_screen/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sheetsFlutter.init();

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
  } else if(Platform.isIOS){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCDHTla8kgFpCoSan3XCj0i5IK-Kixjs3w",
        appId: "1:158409675408:ios:3acfc6e2d48eae20f67e15",
        messagingSenderId: "158409675408",
        projectId: "youmeya-478a9",
        storageBucket: "youmeya-478a9.appspot.com",
      ),
    );
  }
  else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        // You can perform additional actions like fetching user data here
        print(user);
      }
    });
    super.initState();

  }

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
        future: FirebaseAuth.instance.authStateChanges().single,
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If authentication state is still loading, show splash screen
            return const SplashScreen();
          } else {
            // If user is logged in, navigate to home screen
            if (snapshot.hasData && snapshot.data != null) {
              return NavBar(
                currentIndex: 0.obs,
              );
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
