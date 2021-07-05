import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wastebudd_app/Screens/mapScreen.dart';
import 'package:wastebudd_app/Screens/onboardScreen.dart';
import 'package:provider/provider.dart';
import 'Login/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   home: OnBoardingPage(),
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authState,
        ),
      ],
      child: MaterialApp(
        title: "APP",
        home: AuthWrapper(),
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = context.watch<User>();

    if (user != null){
      return MapScreen();
    }

    return OnBoardingPage();
  }
  
}
