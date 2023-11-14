import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mental_health/screens/auth_screen.dart';
import 'package:mental_health/screens/home_screen.dart';
import 'package:mental_health/screens/splash_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),

        useMaterial3: true,
      ),
      home: StreamBuilder(
// Stream to listen to authentication state changes
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
// Show splash screen while connection state is waiting
            if(snapshot.connectionState == ConnectionState.waiting){
              return const SplashScreen();
            }
// If user is authenticated, show the chat screen
            if (snapshot.hasData) {
              return const HomeScreen();
            }
// If user is not authenticated, show the authentication screen
            return const AuthScreen();
          },
        )
    );
  }
}
